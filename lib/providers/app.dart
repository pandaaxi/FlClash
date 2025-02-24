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
List<Group> currentGroups(Ref ref) {
  final mode =
  ref.watch(patchClashConfigProvider.select((state) => state.mode));
  final groups = ref.watch(groupsProvider);
  return switch (mode) {
    Mode.direct => [],
    Mode.global => groups.toList(),
    Mode.rule => groups
        .where((item) => item.hidden == false)
        .where((element) => element.name != GroupName.GLOBAL.name)
        .toList(),
  };
}

@riverpod
class Logs extends _$Logs {
  @override
  FixedList<Log> build() {
    return globalState.appState.logs;
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
    return globalState.appState.requests;
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
    return globalState.appState.traffics;
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
    return globalState.appState.totalTraffic;
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
class CurrentPageLabel extends _$CurrentPageLabel {
  @override
  PageLabel build() {
    return globalState.appState.pageLabel;
  }

  @override
  set state(PageLabel value) {
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
