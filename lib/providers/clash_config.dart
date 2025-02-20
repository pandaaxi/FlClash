import 'package:fl_clash/models/clash_config.dart';
import 'package:fl_clash/state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'generated/clash_config.g.dart';

@riverpod
class PatchClashConfig extends _$PatchClashConfig{
  @override
  ClashConfig build() {
    return globalState.config.patchClashConfig;
  }
}

// @riverpod
// class MixedPort extends _$MixedPort {
//   @override
//   int build() {
//     return clash.defaultMixedPort;
//   }
// }
//
// @riverpod
// class Mode extends _$Mode {
//   @override
//   enums.Mode build() {
//     return enums.Mode.rule;
//   }
// }
//
// @riverpod
// class AllowLan extends _$AllowLan {
//   @override
//   bool build() {
//     return false;
//   }
// }
//
// @riverpod
// class LogLevel extends _$LogLevel {
//   @override
//   enums.LogLevel build() {
//     return enums.LogLevel.info;
//   }
// }
//
// @riverpod
// class Ipv6 extends _$Ipv6 {
//   @override
//   bool build() {
//     return false;
//   }
// }
//
// @riverpod
// class FindProcessMode extends _$FindProcessMode {
//   @override
//   enums.FindProcessMode build() {
//     return enums.FindProcessMode.off;
//   }
// }
//
// @riverpod
// class KeepAliveInterval extends _$KeepAliveInterval {
//   @override
//   int build() {
//     return 0;
//   }
// }
//
// @riverpod
// class UnifiedDelay extends _$UnifiedDelay {
//   @override
//   bool build() {
//     return true;
//   }
// }
//
// @riverpod
// class TcpConcurrent extends _$TcpConcurrent {
//   @override
//   bool build() {
//     return true;
//   }
// }
//
// @riverpod
// class Tun extends _$Tun {
//   @override
//   clash.Tun build() {
//     return clash.defaultTun;
//   }
// }
//
// @riverpod
// class Dns extends _$Dns {
//   @override
//   clash.Dns build() {
//     return clash.defaultDns;
//   }
// }
//
// @riverpod
// class GeoXUrl extends _$GeoXUrl {
//   @override
//   clash.GeoXUrl build() {
//     return clash.defaultGeoXUrl;
//   }
// }
//
// @riverpod
// class GeodataLoader extends _$GeodataLoader {
//   @override
//   enums.GeodataLoader build() {
//     return enums.GeodataLoader.memconservative;
//   }
// }
//
// @riverpod
// class GlobalUa extends _$GlobalUa {
//   @override
//   String? build() {
//     return null;
//   }
// }
//
// @riverpod
// class ExternalController extends _$ExternalController {
//   @override
//   enums.ExternalControllerStatus build() {
//     return enums.ExternalControllerStatus.close;
//   }
// }
//
// @riverpod
// class Hosts extends _$Hosts {
//   @override
//   clash.HostsMap build() {
//     return {};
//   }
// }
