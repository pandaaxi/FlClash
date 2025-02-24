import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';

double get listHeaderHeight {
  final measure = globalState.measure;
  return 24 + measure.titleMediumHeight + 4 + measure.bodyMediumHeight;
}

double getItemHeight(ProxyCardType proxyCardType) {
  final measure = globalState.measure;
  final baseHeight =
      12 * 2 + measure.bodyMediumHeight * 2 + measure.bodySmallHeight + 8 + 4;
  return switch (proxyCardType) {
    ProxyCardType.expand => baseHeight + measure.labelSmallHeight + 8,
    ProxyCardType.shrink => baseHeight,
    ProxyCardType.min => baseHeight - measure.bodyMediumHeight,
  };
}

proxyDelayTest(Proxy proxy, [String? testUrl]) async {
  final appController = globalState.appController;
  final proxyName =
      appController.ref.read(getRealProxyNameProvider(proxy.name));
  final realTestUrl = appController.ref.read(getRealTestUrlProvider(testUrl));
  appController.setDelay(
    Delay(
      url: realTestUrl,
      name: proxyName,
      value: 0,
    ),
  );
  appController.setDelay(
    await clashCore.getDelay(
      realTestUrl,
      proxyName,
    ),
  );
}

delayTest(List<Proxy> proxies, [String? testUrl]) async {
  final appController = globalState.appController;
  final proxyNames = proxies
      .map((proxy) => appController.appState.getRealProxyName(proxy.name))
      .toSet()
      .toList();

  final url = appController.getRealTestUrl(testUrl);

  final delayProxies = proxyNames.map<Future>((proxyName) async {
    globalState.appController.setDelay(
      Delay(
        url: url,
        name: proxyName,
        value: 0,
      ),
    );
    globalState.appController.setDelay(
      await clashCore.getDelay(
        url,
        proxyName,
      ),
    );
  }).toList();

  final batchesDelayProxies = delayProxies.batch(100);
  for (final batchDelayProxies in batchesDelayProxies) {
    await Future.wait(batchDelayProxies);
  }
  appController.appState.sortNum++;
}

double getScrollToSelectedOffset({
  required String groupName,
  required List<Proxy> proxies,
}) {
  final appController = globalState.appController;
  final columns = other.getProxiesColumns(
    appController.appState.viewWidth,
    appController.config.proxiesStyle.layout,
  );
  final proxyCardType = appController.config.proxiesStyle.cardType;
  final selectedName = appController.getCurrentSelectedName(groupName);
  final findSelectedIndex = proxies.indexWhere(
    (proxy) => proxy.name == selectedName,
  );
  final selectedIndex = findSelectedIndex != -1 ? findSelectedIndex : 0;
  final rows = (selectedIndex / columns).floor();
  return rows * getItemHeight(proxyCardType) + (rows - 1) * 8;
}
