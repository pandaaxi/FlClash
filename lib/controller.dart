import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/archive.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/clash_config.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart';
import 'package:re_highlight/styles/base16/colors.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'models/models.dart';

class AppController {
  bool lastTunEnable = false;
  int? lastProfileModified;

  final BuildContext context;
  final WidgetRef ref;

  AppController(this.context, this.ref);

  updateClashConfigDebounce() {
    debouncer.call(DebounceTag.updateClashConfig, updateClashConfig);
  }

  updateGroupsDebounce() {
    debouncer.call(DebounceTag.updateGroups, updateGroups);
  }

  addCheckIpNumDebounce() {
    debouncer.call(DebounceTag.addCheckIpNum, () {
      ref.read(checkIpNumProvider.notifier).add();
    });
  }

  applyProfileDebounce() {
    debouncer.call(DebounceTag.addCheckIpNum, () {
      applyProfile(isPrue: true);
    });
  }

  savePreferencesDebounce() {
    debouncer.call(DebounceTag.savePreferences, savePreferences);
  }

  changeProxyDebounce(String groupName, String proxyName) {
    debouncer.call(DebounceTag.changeProxy,
        (String groupName, String proxyName) async {
      await changeProxy(
        groupName: groupName,
        proxyName: proxyName,
      );
      await updateGroups();
    }, args: [groupName, proxyName]);
  }

  restartCore() async {
    await clashService?.reStart();
    await initCore();

    if (ref.read(runTimeProvider.notifier).isStart) {
      await globalState.handleStart();
    }
  }

  updateStatus(bool isStart) async {
    if (isStart) {
      await globalState.handleStart([
        updateRunTime,
        updateTraffic,
      ]);
      final currentLastModified =
          await config.getCurrentProfile()?.profileLastModified;
      if (currentLastModified == null ||
          globalState.lastProfileModified == null) {
        addCheckIpNumDebounce();
        return;
      }
      if (currentLastModified <= (globalState.lastProfileModified ?? 0)) {
        addCheckIpNumDebounce();
        return;
      }
      applyProfileDebounce();
    } else {
      await globalState.handleStop();
      await clashCore.resetTraffic();
      appFlowingState.traffics = [];
      appFlowingState.totalTraffic = Traffic();
      appFlowingState.runTime = null;
      tray.updateTrayTitle(null);
      addCheckIpNumDebounce();
    }
  }

  updateRunTime() {
    final startTime = globalState.startTime;
    if (startTime != null) {
      final startTimeStamp = startTime.millisecondsSinceEpoch;
      final nowTimeStamp = DateTime.now().millisecondsSinceEpoch;
      appFlowingState.runTime = nowTimeStamp - startTimeStamp;
    } else {
      appFlowingState.runTime = null;
    }
  }

  updateTraffic() {
    globalState.updateTraffic(
      config: config,
      appFlowingState: appFlowingState,
    );
  }

  addProfile(Profile profile) async {
    config.setProfile(profile);
    if (config.currentProfileId != null) return;
    await changeProfile(profile.id);
  }

  deleteProfile(String id) async {
    config.deleteProfileById(id);
    clearEffect(id);
    if (config.currentProfileId == id) {
      if (config.profiles.isNotEmpty) {
        final updateId = config.profiles.first.id;
        changeProfile(updateId);
      } else {
        changeProfile(null);
        updateStatus(false);
      }
    }
  }

  updateProviders() async {
    await globalState.updateProviders(appState);
  }

  updateLocalIp() async {
    appFlowingState.localIp = null;
    await Future.delayed(commonDuration);
    appFlowingState.localIp = await other.getLocalIpAddress();
  }

  Future<void> updateProfile(Profile profile) async {
    final newProfile = await profile.update();
    config.setProfile(
      newProfile.copyWith(isUpdating: false),
    );
    if (profile.id == config.currentProfile?.id) {
      applyProfileDebounce();
    }
  }

  setProfile(Profile profile) {
    config.setProfile(profile);
    if (profile.id == config.currentProfile?.id) {
      applyProfileDebounce();
    }
  }

  Future<void> updateClashConfig([bool? isPatch]) async {
    final commonScaffoldState = globalState.homeScaffoldKey.currentState;
    if (commonScaffoldState?.mounted != true) return;
    await commonScaffoldState?.loadingRun(() async {
      await _updateClashConfig(
        isPatch,
      );
    });
  }

  Future<void> _updateClashConfig([bool? isPatch]) async {
    final profile = ref.watch(currentProfileProvider);
    await ref.read(currentProfileProvider)?.checkAndUpdate();
    final patchConfig = ref.read(patchClashConfigProvider);
    final appSetting = ref.read(appSettingProvider);
    bool enableTun = patchConfig.tun.enable;
    if (enableTun != lastTunEnable &&
        lastTunEnable == false &&
        !Platform.isAndroid) {
      final code = await system.authorizeCore();
      switch (code) {
        case AuthorizeCode.none:
          break;
        case AuthorizeCode.success:
          lastTunEnable = enableTun;
          await restartCore();
          return;
        case AuthorizeCode.error:
          enableTun = false;
      }
    }
    if (appSetting.openLogs) {
      clashCore.startLog();
    } else {
      clashCore.stopLog();
    }
    final res = await clashCore.updateConfig(
      getUpdateConfigParams(isPatch),
    );
    if (res.isNotEmpty) throw res;
    lastTunEnable = enableTun;
    lastProfileModified = await profile?.profileLastModified;
  }

  UpdateConfigParams getUpdateConfigParams([bool? isPatch]) {
    return globalState.getUpdateConfigParams(
      clashConfig: ref.read(patchClashConfigProvider),
      selectedMap: ref.read(selectedDataSourceProvider),
      overrideDns: ref.read(overrideDnsProvider),
      testUrl: ref.read(appSettingProvider).testUrl,
      isPatch: isPatch,
    );
  }

  Future _applyProfile() async {
    await clashCore.requestGc();
    await updateClashConfig();
    await updateGroups(appState);
    await updateProviders(appState);
  }

  Future applyProfile({bool silence = false}) async {
    if (silence) {
      await _applyProfile();
    } else {
      final commonScaffoldState = globalState.homeScaffoldKey.currentState;
      if (commonScaffoldState?.mounted != true) return;
      await commonScaffoldState?.loadingRun(() async {
        await _applyProfile();
      });
    }
    addCheckIpNumDebounce();
  }


  autoUpdateProfiles() async {
    for (final profile in config.profiles) {
      if (!profile.autoUpdate) continue;
      final isNotNeedUpdate = profile.lastUpdateDate
          ?.add(
            profile.autoUpdateDuration,
          )
          .isBeforeNow;
      if (isNotNeedUpdate == false || profile.type == ProfileType.file) {
        continue;
      }
      try {
        updateProfile(profile);
      } catch (e) {
        appFlowingState.addLog(
          Log(
            logLevel: LogLevel.info,
            payload: e.toString(),
          ),
        );
      }
    }
  }

  updateProfiles() async {
    for (final profile in config.profiles) {
      if (profile.type == ProfileType.file) {
        continue;
      }
      await updateProfile(profile);
    }
  }

  Future<void> updateGroups() async {
    ref.read(groupsProvider.notifier).setState(
          await clashCore.getProxiesGroups(),
        );
  }

  updateSystemColorSchemes(ColorSchemes colorSchemes) {
    ref.read(appSchemesProvider.notifier).setState(colorSchemes);
  }

  savePreferences() async {
    // commonPrint.log("savePreferences");
    // await preferences.saveConfig(config);
    // await preferences.saveClashConfig(clashConfig);
  }

  changeProxy({
    required String groupName,
    required String proxyName,
  }) async {
    await clashCore.changeProxy(
      ChangeProxyParams(
        groupName: groupName,
        proxyName: proxyName,
      ),
    );
    if (ref.read(appSettingProvider).closeConnections) {
      clashCore.closeConnections();
    }
    addCheckIpNumDebounce();
  }

  handleBackOrExit() async {
    if (ref.read(appSettingProvider).minimizeOnExit) {
      if (system.isDesktop) {
        await savePreferencesDebounce();
      }
      await system.back();
    } else {
      await handleExit();
    }
  }

  handleExit() async {
    try {
      await updateStatus(false);
      await clashCore.shutdown();
      await clashService?.destroy();
      await proxy?.stopProxy();
      await savePreferences();
    } finally {
      system.exit();
    }
  }

  autoCheckUpdate() async {
    if (!ref.read(appSettingProvider).autoCheckUpdate) return;
    final res = await request.checkForUpdate();
    checkUpdateResultHandle(data: res);
  }

  checkUpdateResultHandle({
    Map<String, dynamic>? data,
    bool handleError = false,
  }) async {
    if (data != null) {
      final tagName = data['tag_name'];
      final body = data['body'];
      final submits = other.parseReleaseBody(body);
      final textTheme = context.textTheme;
      final res = await globalState.showMessage(
        title: appLocalizations.discoverNewVersion,
        message: TextSpan(
          text: "$tagName \n",
          style: textTheme.headlineSmall,
          children: [
            TextSpan(
              text: "\n",
              style: textTheme.bodyMedium,
            ),
            for (final submit in submits)
              TextSpan(
                text: "- $submit \n",
                style: textTheme.bodyMedium,
              ),
          ],
        ),
        confirmText: appLocalizations.goDownload,
      );
      if (res != true) {
        return;
      }
      launchUrl(
        Uri.parse("https://github.com/$repository/releases/latest"),
      );
    } else if (handleError) {
      globalState.showMessage(
        title: appLocalizations.checkUpdate,
        message: TextSpan(
          text: appLocalizations.checkUpdateError,
        ),
      );
    }
  }

  _handlePreference() async {
    if (await preferences.isInit) {
      return;
    }
    final res = await globalState.showMessage(
      title: appLocalizations.tip,
      message: TextSpan(text: appLocalizations.cacheCorrupt),
    );
    if (res) {
      final file = File(await appPath.sharedPreferencesPath);
      final isExists = await file.exists();
      if (isExists) {
        await file.delete();
      }
    }
    await handleExit();
  }

  Future<void> initCore() async {
    final isInit = await clashCore.isInit;
    if (!isInit) {
      await clashCore.setState(
        globalState.getCoreState(
          ref.read(currentProfileProvider),
        ),
      );
      await clashCore.init();
    }
    await applyProfile(
      appState: appState,
      config: config,
    );
  }

  init() async {
    await _handlePreference();
    await _handlerDisclaimer();
    await globalState.initCore(
      appState: appState,
      config: config,
    );
    await _initStatus();
    autoLaunch?.updateStatus(
      config.appSetting.autoLaunch,
    );
    autoUpdateProfiles();
    autoCheckUpdate();
    if (!config.appSetting.silentLaunch) {
      window?.show();
    } else {
      window?.hide();
    }
    appState.isInit = true;
  }

  _initStatus() async {
    if (Platform.isAndroid) {
      await globalState.updateStartTime();
    }
    final status =
        globalState.isStart == true ? true : config.appSetting.autoRun;

    await updateStatus(status);
    if (!status) {
      addCheckIpNumDebounce();
    }
  }

  setDelay(Delay delay) {
    appState.setDelay(delay);
  }

  toPage(
    int index, {
    bool hasAnimate = false,
  }) {
    if (index > appState.currentNavigationItems.length - 1) {
      return;
    }
    appState.currentLabel = appState.currentNavigationItems[index].label;
    if ((config.appSetting.isAnimateToPage || hasAnimate)) {
      globalState.pageController?.animateToPage(
        index,
        duration: kTabScrollDuration,
        curve: Curves.easeOut,
      );
    } else {
      globalState.pageController?.jumpToPage(index);
    }
  }

  toProfiles() {
    final index = appState.currentNavigationItems.indexWhere(
      (element) => element.label == "profiles",
    );
    if (index != -1) {
      toPage(index);
    }
  }

  initLink() {
    linkManager.initAppLinksListen(
      (url) async {
        final res = await globalState.showMessage(
          title: "${appLocalizations.add}${appLocalizations.profile}",
          message: TextSpan(
            children: [
              TextSpan(text: appLocalizations.doYouWantToPass),
              TextSpan(
                text: " $url ",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).colorScheme.primary,
                ),
              ),
              TextSpan(
                  text:
                      "${appLocalizations.create}${appLocalizations.profile}"),
            ],
          ),
        );

        if (res != true) {
          return;
        }
        addProfileFormURL(url);
      },
    );
  }

  Future<bool> showDisclaimer() async {
    return await globalState.showCommonDialog<bool>(
          dismissible: false,
          child: AlertDialog(
            title: Text(appLocalizations.disclaimer),
            content: Container(
              width: dialogCommonWidth,
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: SelectableText(
                  appLocalizations.disclaimerDesc,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop<bool>(false);
                },
                child: Text(appLocalizations.exit),
              ),
              TextButton(
                onPressed: () {
                  config.appSetting = config.appSetting.copyWith(
                    disclaimerAccepted: true,
                  );
                  Navigator.of(context).pop<bool>(true);
                },
                child: Text(appLocalizations.agree),
              )
            ],
          ),
        ) ??
        false;
  }

  _handlerDisclaimer() async {
    if (config.appSetting.disclaimerAccepted) {
      return;
    }
    final isDisclaimerAccepted = await showDisclaimer();
    if (!isDisclaimerAccepted) {
      await handleExit();
    }
    return;
  }

  addProfileFormURL(String url) async {
    if (globalState.navigatorKey.currentState?.canPop() ?? false) {
      globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    toProfiles();
    final commonScaffoldState = globalState.homeScaffoldKey.currentState;
    if (commonScaffoldState?.mounted != true) return;
    final profile = await commonScaffoldState?.loadingRun<Profile>(
      () async {
        return await Profile.normal(
          url: url,
        ).update();
      },
      title: "${appLocalizations.add}${appLocalizations.profile}",
    );
    if (profile != null) {
      await addProfile(profile);
    }
  }

  addProfileFormFile() async {
    final platformFile = await globalState.safeRun(picker.pickerFile);
    final bytes = platformFile?.bytes;
    if (bytes == null) {
      return null;
    }
    if (!context.mounted) return;
    globalState.navigatorKey.currentState?.popUntil((route) => route.isFirst);
    toProfiles();
    final commonScaffoldState = globalState.homeScaffoldKey.currentState;
    if (commonScaffoldState?.mounted != true) return;
    final profile = await commonScaffoldState?.loadingRun<Profile?>(
      () async {
        await Future.delayed(const Duration(milliseconds: 300));
        return await Profile.normal(label: platformFile?.name).saveFile(bytes);
      },
      title: "${appLocalizations.add}${appLocalizations.profile}",
    );
    if (profile != null) {
      await addProfile(profile);
    }
  }

  addProfileFormQrCode() async {
    final url = await globalState.safeRun(picker.pickerConfigQRCode);
    if (url == null) return;
    addProfileFormURL(url);
  }

  updateViewWidth(double width) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      appState.viewWidth = width;
    });
  }

  int? getDelay(String proxyName, [String? url]) {
    final currentDelayMap = appState.delayMap[getRealTestUrl(url)];
    return currentDelayMap?[appState.getRealProxyName(proxyName)];
  }

  String getRealTestUrl(String? url) {
    if (url == null || url.isEmpty) {
      return config.appSetting.testUrl;
    }
    return url;
  }

  List<Proxy> _sortOfName(List<Proxy> proxies) {
    return List.of(proxies)
      ..sort(
        (a, b) => other.sortByChar(
          other.getPinyin(a.name),
          other.getPinyin(b.name),
        ),
      );
  }

  List<Proxy> _sortOfDelay(String url, List<Proxy> proxies) {
    return List.of(proxies)
      ..sort(
        (a, b) {
          final aDelay = getDelay(a.name, url);
          final bDelay = getDelay(b.name, url);
          if (aDelay == null && bDelay == null) {
            return 0;
          }
          if (aDelay == null || aDelay == -1) {
            return 1;
          }
          if (bDelay == null || bDelay == -1) {
            return -1;
          }
          return aDelay.compareTo(bDelay);
        },
      );
  }

  List<Proxy> getSortProxies(List<Proxy> proxies, [String? url]) {
    return switch (config.proxiesStyle.sortType) {
      ProxiesSortType.none => proxies,
      ProxiesSortType.delay => _sortOfDelay(getRealTestUrl(url), proxies),
      ProxiesSortType.name => _sortOfName(proxies),
    };
  }

  String getCurrentSelectedName(String groupName) {
    final group = appState.getGroupWithName(groupName);
    return group?.getCurrentSelectedName(
            config.currentSelectedMap[groupName] ?? '') ??
        '';
  }

  clearEffect(String profileId) async {
    final profilePath = await appPath.getProfilePath(profileId);
    final providersPath = await appPath.getProvidersPath(profileId);
    return await Isolate.run(() async {
      if (profilePath != null) {
        await File(profilePath).delete(recursive: true);
      }
      if (providersPath != null) {
        await File(providersPath).delete(recursive: true);
      }
    });
  }

  bool get isMobileView {
    return appState.viewMode == ViewMode.mobile;
  }

  updateTun() {
    config.patchClashConfig = config.patchClashConfig.copyWith.tun(
      enable: !config.patchClashConfig.tun.enable,
    );
  }

  updateSystemProxy() {
    config.networkProps = config.networkProps.copyWith(
      systemProxy: !config.networkProps.systemProxy,
    );
  }

  updateStart() {
    updateStatus(!appFlowingState.isStart);
  }

  changeMode(Mode mode) {
    config.patchClashConfig = config.patchClashConfig.copyWith(
      mode: mode,
    );
    if (mode == Mode.global) {
      config.updateCurrentGroupName(GroupName.GLOBAL.name);
    }
    addCheckIpNumDebounce();
  }

  updateAutoLaunch() {
    config.appSetting = config.appSetting.copyWith(
      autoLaunch: !config.appSetting.autoLaunch,
    );
  }

  updateVisible() async {
    final visible = await window?.isVisible();
    if (visible != null && !visible) {
      window?.show();
    } else {
      window?.hide();
    }
  }

  updateMode() {
    final index =
        Mode.values.indexWhere((item) => item == config.patchClashConfig.mode);
    if (index == -1) {
      return;
    }
    final nextIndex = index + 1 > Mode.values.length - 1 ? 0 : index + 1;
    config.patchClashConfig = config.patchClashConfig.copyWith(
      mode: Mode.values[nextIndex],
    );
  }

  Future<bool> exportLogs() async {
    final logsRaw = appFlowingState.logs.map(
      (item) => item.toString(),
    );
    final data = await Isolate.run<List<int>>(() async {
      final logsRawString = logsRaw.join("\n");
      return utf8.encode(logsRawString);
    });
    return await picker.saveFile(
          other.logFile,
          Uint8List.fromList(data),
        ) !=
        null;
  }

  Future<List<int>> backupData() async {
    final homeDirPath = await appPath.homeDirPath;
    final profilesPath = await appPath.profilesPath;
    final configJson = config.toJson();
    return Isolate.run<List<int>>(() async {
      final archive = Archive();
      archive.add("config.json", configJson);
      await archive.addDirectoryToArchive(profilesPath, homeDirPath);
      final zipEncoder = ZipEncoder();
      return zipEncoder.encode(archive) ?? [];
    });
  }

  updateTray([bool focus = false]) async {
    tray.update(
      appState: appState,
      appFlowingState: appFlowingState,
      config: config,
      focus: focus,
    );
  }

  recoveryData(
    List<int> data,
    RecoveryOption recoveryOption,
  ) async {
    final archive = await Isolate.run<Archive>(() {
      final zipDecoder = ZipDecoder();
      return zipDecoder.decodeBytes(data);
    });
    final homeDirPath = await appPath.homeDirPath;
    final configs =
        archive.files.where((item) => item.name.endsWith(".json")).toList();
    final profiles =
        archive.files.where((item) => !item.name.endsWith(".json"));
    final configIndex =
        configs.indexWhere((config) => config.name == "config.json");
    if (configIndex == -1) throw "invalid backup.zip";
    final configFile = configs[configIndex];
    final tempConfig = Config.fromJson(
      json.decode(
        utf8.decode(configFile.content),
      ),
    );
    for (final profile in profiles) {
      final filePath = join(homeDirPath, profile.name);
      final file = File(filePath);
      await file.create(recursive: true);
      await file.writeAsBytes(profile.content);
    }
    config.update(tempConfig, recoveryOption);
    final clashConfigIndex =
        configs.indexWhere((config) => config.name == "clashConfig.json");
    if (clashConfigIndex == -1) {
      return;
    }
    final clashConfigFile = configs[clashConfigIndex];
    config.patchClashConfig = ClashConfig.fromJson(
      json.decode(
        utf8.decode(
          clashConfigFile.content,
        ),
      ),
    );
  }
}
