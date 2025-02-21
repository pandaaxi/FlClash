import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

typedef OnSelected = void Function(int index);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  _updatePageController(List<NavigationItem> navigationItems) {
    final pageLabel = globalState.appState.pageLabel;
    final index = navigationItems.lastIndexWhere(
      (element) => element.label == pageLabel,
    );
    final pageIndex = index == -1 ? 0 : index;
    if (globalState.pageController != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        globalState.appController.toPage(
          pageIndex,
          hasAnimate: true,
        );
      });
    } else {
      globalState.pageController = PageController(
        initialPage: pageIndex,
        keepPage: true,
      );
    }
  }

  Widget _buildPageView() {
    return Consumer(
      builder: (_, ref, __) {
        final navigationItems = ref.watch(currentNavigationsProvider);
        _updatePageController(navigationItems);
        return PageView.builder(
          controller: globalState.pageController,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: navigationItems.length,
          itemBuilder: (_, index) {
            final navigationItem = navigationItems[index];
            return KeepScope(
              keep: navigationItem.keep,
              key: Key(navigationItem.label),
              child: navigationItem.fragment,
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackScope(
      child: Consumer(
        builder: (_, ref, child) {
          final state = ref.watch(homeStateProvider);
          final viewMode = state.viewMode;
          final navigationItems = state.navigationItems;
          final pageLabel = state.pageLabel;
          final index = navigationItems.lastIndexWhere(
            (element) => element.label == pageLabel,
          );
          final currentIndex = index == -1 ? 0 : index;
          final navigationBar = CommonNavigationBar(
            viewMode: viewMode,
            navigationItems: navigationItems,
            currentIndex: currentIndex,
          );
          final bottomNavigationBar =
              viewMode == ViewMode.mobile ? navigationBar : null;
          final sideNavigationBar =
              viewMode != ViewMode.mobile ? navigationBar : null;
          return CommonScaffold(
            key: globalState.homeScaffoldKey,
            title: Intl.message(
              pageLabel,
            ),
            sideNavigationBar: sideNavigationBar,
            body: child!,
            bottomNavigationBar: bottomNavigationBar,
          );
        },
        child: _buildPageView(),
      ),
    );
  }
}

class CommonNavigationBar extends ConsumerWidget {
  final ViewMode viewMode;
  final List<NavigationItem> navigationItems;
  final int currentIndex;

  const CommonNavigationBar({
    super.key,
    required this.viewMode,
    required this.navigationItems,
    required this.currentIndex,
  });

  _updateSafeMessageOffset(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = context.size;
      if (viewMode == ViewMode.mobile) {
        globalState.safeMessageOffsetNotifier.value = Offset(
          0,
          -(size?.height ?? 0),
        );
      } else {
        globalState.safeMessageOffsetNotifier.value = Offset(
          size?.width ?? 0,
          0,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context, ref) {
    _updateSafeMessageOffset(context);
    if (viewMode == ViewMode.mobile) {
      return NavigationBar(
        destinations: navigationItems
            .map(
              (e) => NavigationDestination(
                icon: e.icon,
                label: Intl.message(e.label),
              ),
            )
            .toList(),
        onDestinationSelected: globalState.appController.toPage,
        selectedIndex: currentIndex,
      );
    }
    final showLabel = ref.watch(appSettingProvider).showLabel;
    return Material(
      color: context.colorScheme.surfaceContainer,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: IntrinsicHeight(
                child: NavigationRail(
                  backgroundColor: context.colorScheme.surfaceContainer,
                  selectedIconTheme: IconThemeData(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  unselectedIconTheme: IconThemeData(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  selectedLabelTextStyle:
                      context.textTheme.labelLarge!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                  unselectedLabelTextStyle:
                      context.textTheme.labelLarge!.copyWith(
                    color: context.colorScheme.onSurface,
                  ),
                  destinations: navigationItems
                      .map(
                        (e) => NavigationRailDestination(
                          icon: e.icon,
                          label: Text(
                            Intl.message(e.label),
                          ),
                        ),
                      )
                      .toList(),
                  onDestinationSelected: globalState.appController.toPage,
                  extended: false,
                  selectedIndex: currentIndex,
                  labelType: showLabel
                      ? NavigationRailLabelType.all
                      : NavigationRailLabelType.none,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          IconButton(
            onPressed: () {
              ref.read(appSettingProvider.notifier).updateState(
                    (state) => state.copyWith(
                      showLabel: !state.showLabel,
                    ),
                  );
            },
            icon: const Icon(Icons.menu),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
