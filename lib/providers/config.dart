import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'generated/config.g.dart';

@riverpod
class AppSetting extends _$AppSetting {
  @override
  AppSettingProps build() {
    return globalState.config.appSetting;
  }
}

@riverpod
class WindowSetting extends _$WindowSetting {
  @override
  WindowProps build() {
    return globalState.config.windowProps;
  }
}

@riverpod
class VpnSetting extends _$VpnSetting {
  @override
  VpnProps build() {
    return globalState.config.vpnProps;
  }
}

@riverpod
class NetworkSetting extends _$NetworkSetting {
  @override
  NetworkProps build() {
    return globalState.config.networkProps;
  }
}

@riverpod
class ThemeSetting extends _$ThemeSetting {
  @override
  ThemeProps build() {
    return globalState.config.themeProps;
  }
}

@riverpod
class Profiles extends _$Profiles {
  @override
  List<Profile> build() {
    return globalState.config.profiles;
  }
}

@riverpod
class CurrentProfileId extends _$CurrentProfileId {
  @override
  String? build() {
    return globalState.config.currentProfileId;
  }

  setState(String? value) {
    if (value == state) return;
    state = value;
  }
}

@riverpod
Profile? currentProfile(Ref ref) {
  final profileId = ref.watch(currentProfileIdProvider);
  final profiles = ref.watch(profilesProvider);
  final index = profiles.indexWhere((profile) => profile.id == profileId);
  return index == -1 ? null : profiles[index];
}

@riverpod
class DAVSetting extends _$DAVSetting {
  @override
  DAV? build() {
    return globalState.config.dav;
  }
}

@riverpod
class OverrideDns extends _$OverrideDns {
  @override
  bool build() {
    return globalState.config.overrideDns;
  }
}

@riverpod
class IsAccessControl extends _$IsAccessControl {
  @override
  bool build() {
    return globalState.config.isAccessControl;
  }
}

@riverpod
class AccessControlSetting extends _$AccessControlSetting {
  @override
  AccessControl build() {
    return globalState.config.accessControl;
  }
}

@riverpod
class HotKeyActions extends _$HotKeyActions {
  @override
  List<HotKeyAction> build() {
    return globalState.config.hotKeyActions;
  }
}

@riverpod
class ProxiesStyleSetting extends _$ProxiesStyleSetting {
  @override
  ProxiesStyle build() {
    return globalState.config.proxiesStyle;
  }
}
