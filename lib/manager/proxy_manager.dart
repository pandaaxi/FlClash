import 'package:fl_clash/common/proxy.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/app.dart';
import 'package:fl_clash/providers/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProxyManager extends StatelessWidget {
  final Widget child;

  const ProxyManager({super.key, required this.child});

  _updateProxy(ProxyState proxyState) async {
    final isStart = proxyState.isStart;
    final systemProxy = proxyState.systemProxy;
    final port = proxyState.port;
    if (isStart && systemProxy) {
      proxy?.startProxy(port, proxyState.bassDomain);
    } else {
      proxy?.stopProxy();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, ref, child) {
        ref.listen(
          proxyStateProvider,
          (prev, next) {
            if (prev != next) {
              _updateProxy(next);
            }
          },
        );
        return child!;
      },
      child: child,
    );
  }
}
