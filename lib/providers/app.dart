import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/app.g.dart';

@riverpod
List<NavigationItem> navigations(Ref ref) {
  final openLogs = ref.watch(appSettingProvider).openLogs;
  final hasProxies = ref.watch(currentProfileIdProvider) != null;
  return navigation.getItems(
    openLogs: openLogs,
    hasProxies: hasProxies,
  );
}

@riverpod
List<NavigationItem> currentNavigations(Ref ref) {
  final viewWidth = ref.watch(viewWidthProvider);
  final navigations = ref.watch(navigationsProvider);
  final navigationItemMode = switch (viewWidth <= maxMobileWidth) {
    true => NavigationItemMode.mobile,
    false => NavigationItemMode.desktop,
  };
  return navigations
      .where(
        (element) => element.modes.contains(navigationItemMode),
      )
      .toList();
}

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
class Logs extends _$Logs {
  @override
  FixedList<Log> build() {
    return globalState.appState.logs ?? FixedList(1000);
  }

  @override
  set state(FixedList<Log> value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(logs: state);
  }

  addLog(Log value) {
    state = state..add(value);
  }
}

@riverpod
class Requests extends _$Requests {
  @override
  FixedList<Connection> build() {
    return globalState.appState.requests ?? FixedList(1000);
  }

  @override
  set state(FixedList<Connection> value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(requests: state);
  }

  addRequest(Connection value) {
    state = state..add(value);
  }
}

@riverpod
class Providers extends _$Providers {
  @override
  List<ExternalProvider> build() {
    return globalState.appState.providers;
  }

  @override
  set state(List<ExternalProvider> value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(providers: state);
  }

  setProvider(ExternalProvider? provider) {
    if (provider == null) return;
    final index = state.indexWhere((item) => item.name == provider.name);
    if (index == -1) return;
    state = List.from(state)..[index] = provider;
  }
}

@riverpod
class Packages extends _$Packages {
  @override
  List<Package> build() {
    return globalState.appState.packages;
  }

  @override
  set state(List<Package> value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(
      packages: value,
    );
  }
}

@riverpod
class AppBrightness extends _$AppBrightness {
  @override
  Brightness? build() {
    return globalState.appState.brightness;
  }

  @override
  set state(Brightness? value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(brightness: state);
  }

  setState(Brightness? value) {
    state = value;
  }
}

@riverpod
class Traffics extends _$Traffics {
  @override
  FixedList<Traffic> build() {
    return globalState.appState.traffics ?? FixedList(1000);
  }

  @override
  set state(FixedList<Traffic> value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(traffics: state);
  }

  addTraffic(Traffic value) {
    state = state..add(value);
  }

  clear() {
    state = state..clear();
  }
}

@riverpod
class TotalTraffic extends _$TotalTraffic {
  @override
  Traffic build() {
    return globalState.appState.totalTraffic ?? Traffic();
  }

  @override
  set state(Traffic newTraffic) {
    state = newTraffic;
    globalState.appState = globalState.appState.copyWith(
      totalTraffic: state,
    );
  }
}

@riverpod
class LocalIp extends _$LocalIp {
  @override
  String? build() {
    return globalState.appState.localIp;
  }

  @override
  set state(String? value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(
      localIp: state,
    );
  }
}

@riverpod
class RunTime extends _$RunTime {
  @override
  int? build() {
    return globalState.appState.runTime;
  }

  @override
  set state(int? value) {
    super.state = value;
    globalState.appState = globalState.appState.copyWith(
      runTime: value,
    );
  }

  bool get isStart {
    return state != null;
  }
}

@riverpod
class ViewWidth extends _$ViewWidth {
  @override
  double build() {
    return globalState.appState.viewWidth;
  }

  @override
  set state(double value) {
    if (value != state) {
      return;
    }
    state = value;
    globalState.appState = globalState.appState.copyWith(
      viewWidth: state,
    );
  }

  ViewMode get viewMode => other.getViewMode(state);

  bool get isMobileView => viewMode == ViewMode.mobile;
}

@riverpod
class Init extends _$Init {
  @override
  bool build() {
    return globalState.appState.isInit;
  }

  @override
  set state(bool value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      isInit: state,
    );
  }
}

@riverpod
class PageLabel extends _$PageLabel {
  @override
  String build() {
    return globalState.appState.pageLabel ?? "dashboard";
  }

  @override
  set state(String value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      pageLabel: state,
    );
  }
}

@riverpod
class AppSchemes extends _$AppSchemes {
  @override
  ColorSchemes build() {
    return globalState.appState.colorSchemes;
  }

  @override
  set state(ColorSchemes value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      colorSchemes: value,
    );
  }
}

@riverpod
class SortNum extends _$SortNum {
  @override
  int build() {
    return globalState.appState.sortNum;
  }

  @override
  set state(int value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      sortNum: value,
    );
  }

  add() => state++;
}

@riverpod
class CheckIpNum extends _$CheckIpNum {
  @override
  int build() {
    return globalState.appState.checkIpNum;
  }

  @override
  set state(int value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      checkIpNum: value,
    );
  }

  add() => state++;
}

@riverpod
class Version extends _$Version {
  @override
  int build() {
    return globalState.appState.version;
  }

  @override
  set state(int value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      version: value,
    );
  }
}

@riverpod
class Groups extends _$Groups {
  @override
  List<Group> build() {
    return globalState.appState.groups;
  }

  @override
  set state(List<Group> value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      groups: value,
    );
  }

  Group? getGroupWithName(String groupName) {
    final index = state.indexWhere((element) => element.name == groupName);
    return index != -1 ? state[index] : null;
  }
}

@riverpod
class SelectedDataSource extends _$SelectedDataSource {
  @override
  Map<String, String> build() {
    return globalState.appState.selectedMap;
  }

  @override
  set state(Map<String, String> value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      selectedMap: value,
    );
  }
}

@riverpod
class DelayDataSource extends _$DelayDataSource {
  @override
  DelayMap build() {
    return globalState.appState.delayMap;
  }

  @override
  set state(DelayMap value) {
    state = value;
    globalState.appState = globalState.appState.copyWith(
      delayMap: value,
    );
  }

  setDelay(Delay delay) {
    if (state[delay.url]?[delay.name] != delay.value) {
      final DelayMap newDelayMap = Map.from(state);
      if (newDelayMap[delay.url] == null) {
        newDelayMap[delay.url] = {};
      }
      newDelayMap[delay.url]![delay.name] = delay.value;
      state = newDelayMap;
    }
  }
}
