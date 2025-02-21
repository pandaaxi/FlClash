import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:fl_clash/clash/clash.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/l10n/l10n.dart';
import 'package:fl_clash/manager/hotkey_manager.dart';
import 'package:fl_clash/manager/manager.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

import 'controller.dart';
import 'models/models.dart';
import 'pages/pages.dart';

class Application extends ConsumerStatefulWidget {
  const Application({
    super.key,
  });

  @override
  ConsumerState<Application> createState() => ApplicationState();
}

class ApplicationState extends ConsumerState<Application> {
  late ColorSchemes systemColorSchemes;
  Timer? _autoUpdateGroupTaskTimer;
  Timer? _autoUpdateProfilesTaskTimer;

  final _pageTransitionsTheme = const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: CommonPageTransitionsBuilder(),
      TargetPlatform.windows: CommonPageTransitionsBuilder(),
      TargetPlatform.linux: CommonPageTransitionsBuilder(),
      TargetPlatform.macOS: CommonPageTransitionsBuilder(),
    },
  );

  ColorScheme _getAppColorScheme({
    required Brightness brightness,
    int? primaryColor,
    required ColorSchemes systemColorSchemes,
  }) {
    if (primaryColor != null) {
      return ColorScheme.fromSeed(
        seedColor: Color(primaryColor),
        brightness: brightness,
      );
    } else {
      return systemColorSchemes.getColorSchemeForBrightness(brightness);
    }
  }

  @override
  void initState() {
    super.initState();
    _autoUpdateGroupTask();
    _autoUpdateProfilesTask();
    globalState.appController = AppController(context, ref);
    globalState.measure = Measure.of(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final currentContext = globalState.navigatorKey.currentContext;
      if (currentContext != null) {
        globalState.appController = AppController(currentContext, ref);
      }
      await globalState.appController.init();
      globalState.appController.initLink();
      app?.initShortcuts();
    });
  }

  _autoUpdateGroupTask() {
    _autoUpdateGroupTaskTimer = Timer(const Duration(milliseconds: 20000), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalState.appController.updateGroupsDebounce();
        _autoUpdateGroupTask();
      });
    });
  }

  _autoUpdateProfilesTask() {
    _autoUpdateProfilesTaskTimer = Timer(const Duration(minutes: 20), () async {
      await globalState.appController.autoUpdateProfiles();
      _autoUpdateProfilesTask();
    });
  }

  _buildPlatformWrap(Widget child) {
    if (system.isDesktop) {
      return WindowManager(
        child: TrayManager(
          child: HotKeyManager(
            child: ProxyManager(
              child: child,
            ),
          ),
        ),
      );
    }
    return AndroidManager(
      child: TileManager(
        child: child,
      ),
    );
  }

  _buildPage(Widget page) {
    if (system.isDesktop) {
      return WindowHeaderContainer(
        child: page,
      );
    }
    return VpnManager(
      child: page,
    );
  }

  _buildWrap(Widget child) {
    return AppStateManager(
      child: ClashManager(
        child: ConnectivityManager(
          onConnectivityChanged: () {
            globalState.appController.updateLocalIp();
            globalState.appController.addCheckIpNumDebounce();
          },
          child: child,
        ),
      ),
    );
  }

  _updateSystemColorSchemes(
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  ) {
    systemColorSchemes = ColorSchemes(
      lightColorScheme: lightDynamic,
      darkColorScheme: darkDynamic,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      globalState.appController.updateSystemColorSchemes(systemColorSchemes);
    });
  }

  @override
  Widget build(context) {
    return _buildPlatformWrap(
      _buildWrap(
        Selector2<AppState, Config, ApplicationSelectorState>(
          selector: (_, appState, config) => ApplicationSelectorState(
            locale: config.appSetting.locale,
            themeMode: config.themeProps.themeMode,
            primaryColor: config.themeProps.primaryColor,
            prueBlack: config.themeProps.prueBlack,
            fontFamily: config.themeProps.fontFamily,
          ),
          builder: (_, state, child) {
            return DynamicColorBuilder(
              builder: (lightDynamic, darkDynamic) {
                _updateSystemColorSchemes(lightDynamic, darkDynamic);
                return MaterialApp(
                  navigatorKey: globalState.navigatorKey,
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate
                  ],
                  builder: (_, child) {
                    return MessageManager(
                      child: LayoutBuilder(
                        builder: (_, container) {
                          final appController = globalState.appController;
                          final maxWidth = container.maxWidth;
                          if (appController.appState.viewWidth != maxWidth) {
                            globalState.appController.updateViewWidth(maxWidth);
                          }
                          return _buildPage(child!);
                        },
                      ),
                    );
                  },
                  scrollBehavior: BaseScrollBehavior(),
                  title: appName,
                  locale: other.getLocaleForString(state.locale),
                  supportedLocales: AppLocalizations.delegate.supportedLocales,
                  themeMode: state.themeMode,
                  theme: ThemeData(
                    useMaterial3: true,
                    fontFamily: state.fontFamily.value,
                    pageTransitionsTheme: _pageTransitionsTheme,
                    colorScheme: _getAppColorScheme(
                      brightness: Brightness.light,
                      systemColorSchemes: systemColorSchemes,
                      primaryColor: state.primaryColor,
                    ),
                  ),
                  darkTheme: ThemeData(
                    useMaterial3: true,
                    fontFamily: state.fontFamily.value,
                    pageTransitionsTheme: _pageTransitionsTheme,
                    colorScheme: _getAppColorScheme(
                      brightness: Brightness.dark,
                      systemColorSchemes: systemColorSchemes,
                      primaryColor: state.primaryColor,
                    ).toPrueBlack(state.prueBlack),
                  ),
                  home: child,
                );
              },
            );
          },
          child: const HomePage(),
        ),
      ),
    );
  }

  @override
  Future<void> dispose() async {
    linkManager.destroy();
    _autoUpdateGroupTaskTimer?.cancel();
    _autoUpdateProfilesTaskTimer?.cancel();
    await clashCore.destroy();
    await globalState.appController.savePreferences();
    await globalState.appController.handleExit();
    super.dispose();
  }
}
