import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/fragments/fragments.dart';
import 'package:fl_clash/models/models.dart';
import 'package:flutter/material.dart';

class Navigation {
  static Navigation? _instance;

  List<NavigationItem> getItems({
    bool openLogs = false,
    bool hasProxies = false,
  }) {
    return [
      const NavigationItem(
        icon: Icon(Icons.space_dashboard),
        label: PageLabel.dashboard,
        fragment: DashboardFragment(),
      ),
      NavigationItem(
        icon: const Icon(Icons.rocket),
        label: PageLabel.proxies,
        fragment: const ProxiesFragment(),
        modes: hasProxies
            ? [NavigationItemMode.mobile, NavigationItemMode.desktop]
            : [],
      ),
      const NavigationItem(
        icon: Icon(Icons.folder),
        label: PageLabel.profiles,
        fragment: ProfilesFragment(),
      ),
      const NavigationItem(
        icon: Icon(Icons.view_timeline),
        label: PageLabel.requests,
        fragment: RequestsFragment(),
        description: "requestsDesc",
        modes: [NavigationItemMode.desktop, NavigationItemMode.more],
      ),
      const NavigationItem(
        icon: Icon(Icons.ballot),
        label: PageLabel.connections,
        fragment: ConnectionsFragment(),
        description: "connectionsDesc",
        modes: [NavigationItemMode.desktop, NavigationItemMode.more],
      ),
      const NavigationItem(
        icon: Icon(Icons.storage),
        label: PageLabel.resources,
        description: "resourcesDesc",
        keep: false,
        fragment: Resources(),
        modes: [NavigationItemMode.more],
      ),
      NavigationItem(
        icon: const Icon(Icons.adb),
        label: PageLabel.logs,
        fragment: const LogsFragment(),
        description: "logsDesc",
        modes: openLogs
            ? [NavigationItemMode.desktop, NavigationItemMode.more]
            : [],
      ),
      const NavigationItem(
        icon: Icon(Icons.construction),
        label: PageLabel.tools,
        fragment: ToolsFragment(),
        modes: [NavigationItemMode.desktop, NavigationItemMode.mobile],
      ),
    ];
  }

  Navigation._internal();

  factory Navigation() {
    _instance ??= Navigation._internal();
    return _instance!;
  }
}

final navigation = Navigation();
