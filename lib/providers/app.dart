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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(
        logs: next,
      );
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(requests: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(providers: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(packages: next);
    }
    return res;
  }
}

@riverpod
class AppBrightness extends _$AppBrightness {
  @override
  Brightness? build() {
    return globalState.appState.brightness;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(brightness: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(traffics: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(totalTraffic: next);
    }
    return res;
  }
}

@riverpod
class LocalIp extends _$LocalIp {
  @override
  String? build() {
    return globalState.appState.localIp;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(localIp: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(runTime: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(viewWidth: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(isInit: next);
    }
    return res;
  }
}

@riverpod
class CurrentPageLabel extends _$CurrentPageLabel {
  @override
  PageLabel build() {
    return globalState.appState.pageLabel;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(pageLabel: next);
    }
    return res;
  }
}

@riverpod
class AppSchemes extends _$AppSchemes {
  @override
  ColorSchemes build() {
    return globalState.appState.colorSchemes;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(colorSchemes: next);
    }
    return res;
  }
}

@riverpod
class SortNum extends _$SortNum {
  @override
  int build() {
    return globalState.appState.sortNum;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(sortNum: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(checkIpNum: next);
    }
    return res;
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
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(version: next);
    }
    return res;
  }
}

@riverpod
class Groups extends _$Groups {
  @override
  List<Group> build() {
    return globalState.appState.groups;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(groups: next);
    }
    return res;
  }
}

@riverpod
class DelayDataSource extends _$DelayDataSource {
  @override
  DelayMap build() {
    return globalState.appState.delayMap;
  }

  @override
  bool updateShouldNotify(previous, next) {
    final res = super.updateShouldNotify(previous, next);
    if (res) {
      globalState.appState = globalState.appState.copyWith(delayMap: next);
    }
    return res;
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
