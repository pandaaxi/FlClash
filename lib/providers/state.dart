import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app.dart';
import 'config.dart';

part 'generated/state.g.dart';

@riverpod
CoreState coreState(Ref ref) {
  final vpnProps = ref.watch(vpnSettingProvider);
  final currentProfile = ref.watch(currentProfileProvider);
  final onlyStatisticsProxy = ref.watch(appSettingProvider).onlyStatisticsProxy;
  return CoreState(
    vpnProps: vpnProps,
    onlyStatisticsProxy: onlyStatisticsProxy,
    currentProfileName: currentProfile?.label ?? currentProfile?.id ?? "",
  );
}

@riverpod
ClashConfigState clashConfigState(Ref ref) {
  final clashConfig = ref.watch(patchClashConfigProvider);
  final overrideDns = ref.watch(overrideDnsProvider);
  return ClashConfigState(
    overrideDns: overrideDns,
    clashConfig: clashConfig,
  );
}

@riverpod
ProxyState proxyState(Ref ref) {
  final isStart = ref.watch(runTimeProvider.notifier).isStart;
  final networkProps = ref.watch(networkSettingProvider);
  final mixedPort = ref.watch(
    patchClashConfigProvider.select((state) => state.mixedPort),
  );
  return ProxyState(
    isStart: isStart,
    systemProxy: networkProps.systemProxy,
    bassDomain: networkProps.bypassDomain,
    port: mixedPort,
  );
}

@riverpod
TrayState trayState(Ref ref) {
  final isStart = ref.watch(runTimeProvider.notifier).isStart;
  final networkProps = ref.watch(networkSettingProvider);
  final clashConfig = ref.watch(
    patchClashConfigProvider,
  );
  final appSetting = ref.watch(
    appSettingProvider,
  );
  final groups = ref.watch(
    groupsProvider,
  );
  final brightness = ref.watch(
    appBrightnessProvider,
  );

  final selectedMap = ref.watch(selectedDataSourceProvider);

  return TrayState(
    mode: clashConfig.mode,
    port: clashConfig.mixedPort,
    autoLaunch: appSetting.autoRun,
    systemProxy: networkProps.systemProxy,
    tunEnable: clashConfig.tun.enable,
    isStart: isStart,
    locale: appSetting.locale,
    brightness: brightness,
    groups: groups,
    selectedMap: selectedMap,
  );
}

@riverpod
VpnState vpnState(Ref ref) {
  final vpnProps = ref.watch(vpnSettingProvider);
  final accessControl = ref.watch(accessControlSettingProvider);
  final stack = ref.watch(
    patchClashConfigProvider.select((state) => state.tun.stack),
  );

  return VpnState(
    accessControl: accessControl,
    stack: stack,
    vpnProps: vpnProps,
  );
}

@riverpod
HomeState homeState(Ref ref) {
  final pageLabel = ref.watch(pageLabelProvider);
  final navigationItems = ref.watch(currentNavigationsProvider);
  final viewMode = ref.watch(viewWidthProvider.notifier).viewMode;
  final locale = ref.watch(appSettingProvider).locale;
  return HomeState(
    pageLabel: pageLabel,
    navigationItems: navigationItems,
    viewMode: viewMode,
    locale: locale,
  );
}

@riverpod
DashboardState dashboardState(Ref ref) {
  final dashboardWidgets =
      ref.watch(appSettingProvider.select((state) => state.dashboardWidgets));
  final viewWidth = ref.watch(viewWidthProvider);
  return DashboardState(
    dashboardWidgets: dashboardWidgets,
    viewWidth: viewWidth,
  );
}

@riverpod
StartButtonSelectorState startButtonSelectorState(Ref ref) {
  final isInit = ref.watch(initProvider);
  final hasProfile =
      ref.watch(profilesProvider.select((state) => state.isEmpty));
  return StartButtonSelectorState(
    isInit: isInit,
    hasProfile: hasProfile,
  );
}

@riverpod
ProfilesSelectorState profilesSelectorState(Ref ref) {
  final currentProfileId = ref.watch(currentProfileIdProvider);
  final profiles = ref.watch(profilesProvider);
  final columns = ref.watch(
      viewWidthProvider.select((state) => other.getProfilesColumns(state)));
  return ProfilesSelectorState(
    profiles: profiles,
    currentProfileId: currentProfileId,
    columns: columns,
  );
}

String _getRealProxyName(
  List<Group> groups,
  SelectedMap selectedMap,
  String proxyName,
) {
  if (proxyName.isEmpty) return proxyName;
  final index = groups.indexWhere((element) => element.name == proxyName);
  if (index == -1) return proxyName;
  final group = groups[index];
  final currentSelectedName =
      group.getCurrentSelectedName(selectedMap[proxyName] ?? '');
  if (currentSelectedName.isEmpty) return proxyName;
  return _getRealProxyName(
    groups,
    selectedMap,
    proxyName,
  );
}

@riverpod
String getRealProxyName(Ref ref, String proxyName) {
  final groups = ref.watch(groupsProvider);
  final selectedMap = ref.watch(selectedDataSourceProvider);
  return _getRealProxyName(groups, selectedMap, proxyName);
}

@riverpod
int? getDelay(
  Ref ref, {
  required String proxyName,
  String? testUrl,
}) {
  final currentTestUrl = ref.watch(appSettingProvider).testUrl;
  final delayMap = ref.watch(delayDataSourceProvider);
  final currentDelayMap = delayMap[testUrl.getSafeValue(currentTestUrl)];
  return currentDelayMap?[proxyName];
}

@riverpod
String? getSelectedProxyName(Ref ref, String groupName) {
  final selectedMap = ref.watch(
      currentProfileProvider.select((state) => state?.selectedMap ?? {}));
  return selectedMap[groupName];
}

@riverpod
String getProxyDesc(Ref ref, Proxy proxy) {
  final groupTypeNamesList = GroupType.values.map((e) => e.name).toList();
  if (!groupTypeNamesList.contains(proxy.type)) {
    return proxy.type;
  } else {
    final groups = ref.watch(groupsProvider);
    final index = groups.indexWhere((element) => element.name == proxy.name);
    if (index == -1) return proxy.type;
    return "${proxy.type}(${groups[index].now ?? '*'})";
  }
}
