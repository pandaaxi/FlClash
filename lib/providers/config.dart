import 'package:fl_clash/common/other.dart';
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

  @override
  set state(AppSettingProps value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      appSetting: value,
    );
  }

  updateState(AppSettingProps Function(AppSettingProps state) builder) {
    state = builder(state);
  }
}

@riverpod
class WindowSetting extends _$WindowSetting {
  @override
  WindowProps build() {
    return globalState.config.windowProps;
  }

  @override
  set state(WindowProps value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      windowProps: value,
    );
  }
}

@riverpod
class VpnSetting extends _$VpnSetting {
  @override
  VpnProps build() {
    return globalState.config.vpnProps;
  }

  @override
  set state(VpnProps value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      vpnProps: value,
    );
  }
}

@riverpod
class NetworkSetting extends _$NetworkSetting {
  @override
  NetworkProps build() {
    return globalState.config.networkProps;
  }

  @override
  set state(NetworkProps value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      networkProps: value,
    );
  }

  updateState(NetworkProps Function(NetworkProps state) builder) {
    state = builder(state);
  }
}

@riverpod
class ThemeSetting extends _$ThemeSetting {
  @override
  ThemeProps build() {
    return globalState.config.themeProps;
  }

  @override
  set state(ThemeProps value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      themeProps: value,
    );
  }
}

@riverpod
class Profiles extends _$Profiles {
  @override
  List<Profile> build() {
    return globalState.config.profiles;
  }

  @override
  set state(List<Profile> value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      profiles: value,
    );
  }

  String? _getLabel(String? label, String id) {
    final realLabel = label ?? id;
    final hasDup = state.indexWhere(
            (element) => element.label == realLabel && element.id != id) !=
        -1;
    if (hasDup) {
      return _getLabel(other.getOverwriteLabel(realLabel), id);
    } else {
      return label;
    }
  }

  setProfile(Profile profile) {
    final List<Profile> profilesTemp = List.from(state);
    final index =
        profilesTemp.indexWhere((element) => element.id == profile.id);
    final updateProfile = profile.copyWith(
      label: _getLabel(profile.label, profile.id),
    );
    if (index == -1) {
      profilesTemp.add(updateProfile);
    } else {
      profilesTemp[index] = updateProfile;
    }
    state = profilesTemp;
  }

  deleteProfileById(String id) {
    state = state.where((element) => element.id != id).toList();
  }
}

@riverpod
class CurrentProfileId extends _$CurrentProfileId {
  @override
  String? build() {
    return globalState.config.currentProfileId;
  }

  @override
  set state(String? value) {
    if (value == state) return;
    state = value;
    globalState.config = globalState.config.copyWith(currentProfileId: value);
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

  @override
  set state(DAV? value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      dav: value,
    );
  }
}

@riverpod
class OverrideDns extends _$OverrideDns {
  @override
  bool build() {
    return globalState.config.overrideDns;
  }

  @override
  set state(bool value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      overrideDns: value,
    );
  }
}

@riverpod
class IsAccessControl extends _$IsAccessControl {
  @override
  bool build() {
    return globalState.config.isAccessControl;
  }

  @override
  set state(bool value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      isAccessControl: value,
    );
  }
}

@riverpod
class AccessControlSetting extends _$AccessControlSetting {
  @override
  AccessControl build() {
    return globalState.config.accessControl;
  }

  @override
  set state(AccessControl value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      accessControl: value,
    );
  }
}

@riverpod
class HotKeyActions extends _$HotKeyActions {
  @override
  List<HotKeyAction> build() {
    return globalState.config.hotKeyActions;
  }

  @override
  set state(List<HotKeyAction> value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      hotKeyActions: value,
    );
  }
}

@riverpod
class ProxiesStyleSetting extends _$ProxiesStyleSetting {
  @override
  ProxiesStyle build() {
    return globalState.config.proxiesStyle;
  }

  @override
  set state(ProxiesStyle value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      proxiesStyle: value,
    );
  }
}

@riverpod
class PatchClashConfig extends _$PatchClashConfig {
  @override
  ClashConfig build() {
    return globalState.config.patchClashConfig;
  }

  updateState(ClashConfig? Function(ClashConfig state) builder) {
    final newState = builder(state);
    if (newState == null) {
      return;
    }
    state = newState;
  }

  @override
  set state(ClashConfig value) {
    super.state = value;
    globalState.config = globalState.config.copyWith(
      patchClashConfig: value,
    );
  }
}
