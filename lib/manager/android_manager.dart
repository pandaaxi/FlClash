import 'package:fl_clash/common/mixin.dart';
import 'package:fl_clash/plugins/app.dart';
import 'package:fl_clash/providers/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AndroidManager extends ConsumerStatefulWidget {
  final Widget child;

  const AndroidManager({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<AndroidManager> createState() => _AndroidContainerState();
}

class _AndroidContainerState extends ConsumerState<AndroidManager>
    with ListenManualMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    subscriptions = [
      ref.listenManual(
        appSettingProvider.select((state) => state.hidden),
        (prev, next) {
          app?.updateExcludeFromRecents(next);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
