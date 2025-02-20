import 'dart:async';
import 'dart:io';

import 'package:animations/animations.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/plugins/service.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'common/common.dart';
import 'controller.dart';
import 'models/models.dart';

typedef UpdateTasks = List<FutureOr Function()>;

class GlobalState {
  static GlobalState? _instance;
  bool isService = false;
  Timer? timer;
  Timer? groupsUpdateTimer;
  late Config config;
  late PackageInfo packageInfo;
  Function? updateCurrentDelayDebounce;
  PageController? pageController;
  late Measure measure;
  DateTime? startTime;
  UpdateTasks tasks = [];
  final safeMessageOffsetNotifier = ValueNotifier(Offset.zero);
  final navigatorKey = GlobalKey<NavigatorState>();
  late AppController appController;
  GlobalKey<CommonScaffoldState> homeScaffoldKey = GlobalKey();

  bool get isStart => startTime != null && startTime!.isBeforeNow;

  GlobalState._internal();

  factory GlobalState() {
    _instance ??= GlobalState._internal();
    return _instance!;
  }

  init() async {
    packageInfo = await PackageInfo.fromPlatform();
    config = await preferences.getConfig() ?? Config();
    await globalState.migrateOldData(config);
  }

  startUpdateTasks([UpdateTasks? tasks]) async {
    if (timer != null && timer!.isActive == true) return;
    if (tasks != null) {
      this.tasks = tasks;
    }
    await executorUpdateTask();
    timer = Timer(const Duration(seconds: 1), () async {
      startUpdateTasks();
    });
  }

  executorUpdateTask() async {
    for (final task in tasks) {
      await task();
    }
    timer = null;
  }

  stopUpdateTasks() {
    if (timer == null || timer?.isActive == false) return;
    timer?.cancel();
    timer = null;
  }

  Future<void> initCore({
    required AppState appState,
    required Config config,
  }) async {
    await globalState.initClash(
      appState: appState,
      config: config,
    );
    await applyProfile(
      appState: appState,
      config: config,
    );
  }


  handleStart([UpdateTasks? tasks]) async {
    startTime ??= DateTime.now();
    await clashCore.startListener();
    await service?.startVpn();
    startUpdateTasks(tasks);
  }

  restartCore({
    required AppState appState,
    required Config config,
    bool isPatch = true,
  }) async {
    await clashService?.reStart();
    await initCore(
      appState: appState,
      config: config,
    );

    if (isStart) {
      await handleStart();
    }
  }

  Future updateStartTime() async {
    startTime = await clashLib?.getRunTime();
  }

  Future handleStop() async {
    startTime = null;
    await clashCore.stopListener();
    await clashLib?.stopTun();
    await service?.stopVpn();
    stopUpdateTasks();
  }

  updateProviders(AppState appState) async {
    appState.providers = await clashCore.getExternalProviders();
  }

  CoreState getCoreState(Profile? profile) {
    return CoreState(
      vpnProps: config.vpnProps,
      onlyStatisticsProxy: config.appSetting.onlyStatisticsProxy,
      currentProfileName: profile?.label ?? profile?.id ?? "",
      bypassDomain: config.networkProps.bypassDomain,
    );
  }

  getUpdateConfigParams({
    required ClashConfig clashConfig,
    String? currentProfileId,
    bool? isPatch,
    required SelectedMap selectedMap,
    required bool overrideDns,
    required String testUrl,
  }) {
    return UpdateConfigParams(
      profileId: currentProfileId ?? "",
      config: clashConfig.copyWith(
        globalUa: clashConfig.globalUa ?? packageInfo.ua,
        tun: clashConfig.tun.copyWith(
          routeAddress: config.networkProps.routeMode == RouteMode.bypassPrivate
              ? defaultBypassPrivateRouteAddress
              : clashConfig.tun.routeAddress,
        ),
      ),
      params: ConfigExtendedParams(
        isPatch: isPatch ?? false,
        selectedMap: selectedMap,
        overrideDns: overrideDns,
        testUrl: testUrl,
      ),
    );
  }

  Future<void> updateGroups(AppState appState) async {
    appState.groups = await clashCore.getProxiesGroups();
  }

  Future<bool?> showMessage<bool>({
    required String title,
    required InlineSpan message,
    String? confirmText,
  }) async {
    return await showCommonDialog<bool>(
      child: Builder(
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Container(
              width: 300,
              constraints: const BoxConstraints(maxHeight: 200),
              child: SingleChildScrollView(
                child: SelectableText.rich(
                  TextSpan(
                    style: Theme.of(context).textTheme.labelLarge,
                    children: [message],
                  ),
                  style: const TextStyle(
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(appLocalizations.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(confirmText ?? appLocalizations.confirm),
              )
            ],
          );
        },
      ),
    );
  }

  Future<T?> showCommonDialog<T>({
    required Widget child,
    bool dismissible = true,
  }) async {
    return await showModal<T>(
      context: navigatorKey.currentState!.context,
      configuration: FadeScaleTransitionConfiguration(
        barrierColor: Colors.black38,
        barrierDismissible: dismissible,
      ),
      builder: (_) => child,
      filter: filter,
    );
  }

  updateTraffic({
    required Config config,
    AppFlowingState? appFlowingState,
  }) async {
    final traffic = await clashCore.getTraffic();
    if (appFlowingState != null) {
      appFlowingState.addTraffic(traffic);
      tray.updateTrayTitle(traffic);
      appFlowingState.totalTraffic = await clashCore.getTotalTraffic();
    }
  }

  Future<T?> safeRun<T>(
    FutureOr<T> Function() futureFunction, {
    String? title,
    bool silence = true,
  }) async {
    try {
      final res = await futureFunction();
      return res;
    } catch (e) {
      if (silence) {
        showNotifier(e.toString());
      } else {
        showMessage(
          title: title ?? appLocalizations.tip,
          message: TextSpan(
            text: e.toString(),
          ),
        );
      }
      return null;
    }
  }

  showNotifier(String text) {
    if (text.isEmpty) {
      return;
    }
    navigatorKey.currentContext?.showNotifier(text);
  }

  openUrl(String url) async {
    final res = await showMessage(
      message: TextSpan(text: url),
      title: appLocalizations.externalLink,
      confirmText: appLocalizations.go,
    );
    if (res != true) {
      return;
    }
    launchUrl(Uri.parse(url));
  }

  Future<void> migrateOldData(Config config) async {
    final clashConfig = await preferences.getClashConfig();
    if (clashConfig != null) {
      config = config.copyWith(
        patchClashConfig: clashConfig,
      );
      preferences.clearClashConfig();
      preferences.saveConfig(config);
    }
  }
}

final globalState = GlobalState();
