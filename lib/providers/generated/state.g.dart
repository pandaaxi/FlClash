// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../state.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$coreStateHash() => r'33f01ee9173525862c89522bf73b3174beb63daa';

/// See also [coreState].
@ProviderFor(coreState)
final coreStateProvider = AutoDisposeProvider<CoreState>.internal(
  coreState,
  name: r'coreStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$coreStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CoreStateRef = AutoDisposeProviderRef<CoreState>;
String _$clashConfigStateHash() => r'0708f81450e740a471c65d1dd5db0ed0dc702b3c';

/// See also [clashConfigState].
@ProviderFor(clashConfigState)
final clashConfigStateProvider = AutoDisposeProvider<ClashConfigState>.internal(
  clashConfigState,
  name: r'clashConfigStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$clashConfigStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClashConfigStateRef = AutoDisposeProviderRef<ClashConfigState>;
String _$proxyStateHash() => r'418464d2ab29bb701ff001ca80396526fd2c8d3a';

/// See also [proxyState].
@ProviderFor(proxyState)
final proxyStateProvider = AutoDisposeProvider<ProxyState>.internal(
  proxyState,
  name: r'proxyStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$proxyStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProxyStateRef = AutoDisposeProviderRef<ProxyState>;
String _$trayStateHash() => r'06ff742a92893667a30bc6a25d13594d83dd74fc';

/// See also [trayState].
@ProviderFor(trayState)
final trayStateProvider = AutoDisposeProvider<TrayState>.internal(
  trayState,
  name: r'trayStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$trayStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TrayStateRef = AutoDisposeProviderRef<TrayState>;
String _$vpnStateHash() => r'7d1d3a99e3de43a60bac03bb38b688e39b60d568';

/// See also [vpnState].
@ProviderFor(vpnState)
final vpnStateProvider = AutoDisposeProvider<VpnState>.internal(
  vpnState,
  name: r'vpnStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$vpnStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef VpnStateRef = AutoDisposeProviderRef<VpnState>;
String _$homeStateHash() => r'e3920251949432a30f499f53bd37caf061bf4727';

/// See also [homeState].
@ProviderFor(homeState)
final homeStateProvider = AutoDisposeProvider<HomeState>.internal(
  homeState,
  name: r'homeStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef HomeStateRef = AutoDisposeProviderRef<HomeState>;
String _$dashboardStateHash() => r'4434206df2753d7df9eb5223c07ddead4ed170fa';

/// See also [dashboardState].
@ProviderFor(dashboardState)
final dashboardStateProvider = AutoDisposeProvider<DashboardState>.internal(
  dashboardState,
  name: r'dashboardStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dashboardStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DashboardStateRef = AutoDisposeProviderRef<DashboardState>;
String _$isCurrentPageHash() => r'a9ec62dbf568221efd5842159ea14e23e7084944';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [isCurrentPage].
@ProviderFor(isCurrentPage)
const isCurrentPageProvider = IsCurrentPageFamily();

/// See also [isCurrentPage].
class IsCurrentPageFamily extends Family<bool> {
  /// See also [isCurrentPage].
  const IsCurrentPageFamily();

  /// See also [isCurrentPage].
  IsCurrentPageProvider call(
    PageLabel pageLabel, {
    bool Function(PageLabel, ViewMode)? handler,
  }) {
    return IsCurrentPageProvider(
      pageLabel,
      handler: handler,
    );
  }

  @override
  IsCurrentPageProvider getProviderOverride(
    covariant IsCurrentPageProvider provider,
  ) {
    return call(
      provider.pageLabel,
      handler: provider.handler,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'isCurrentPageProvider';
}

/// See also [isCurrentPage].
class IsCurrentPageProvider extends AutoDisposeProvider<bool> {
  /// See also [isCurrentPage].
  IsCurrentPageProvider(
    PageLabel pageLabel, {
    bool Function(PageLabel, ViewMode)? handler,
  }) : this._internal(
          (ref) => isCurrentPage(
            ref as IsCurrentPageRef,
            pageLabel,
            handler: handler,
          ),
          from: isCurrentPageProvider,
          name: r'isCurrentPageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$isCurrentPageHash,
          dependencies: IsCurrentPageFamily._dependencies,
          allTransitiveDependencies:
              IsCurrentPageFamily._allTransitiveDependencies,
          pageLabel: pageLabel,
          handler: handler,
        );

  IsCurrentPageProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.pageLabel,
    required this.handler,
  }) : super.internal();

  final PageLabel pageLabel;
  final bool Function(PageLabel, ViewMode)? handler;

  @override
  Override overrideWith(
    bool Function(IsCurrentPageRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: IsCurrentPageProvider._internal(
        (ref) => create(ref as IsCurrentPageRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        pageLabel: pageLabel,
        handler: handler,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<bool> createElement() {
    return _IsCurrentPageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is IsCurrentPageProvider &&
        other.pageLabel == pageLabel &&
        other.handler == handler;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pageLabel.hashCode);
    hash = _SystemHash.combine(hash, handler.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin IsCurrentPageRef on AutoDisposeProviderRef<bool> {
  /// The parameter `pageLabel` of this provider.
  PageLabel get pageLabel;

  /// The parameter `handler` of this provider.
  bool Function(PageLabel, ViewMode)? get handler;
}

class _IsCurrentPageProviderElement extends AutoDisposeProviderElement<bool>
    with IsCurrentPageRef {
  _IsCurrentPageProviderElement(super.provider);

  @override
  PageLabel get pageLabel => (origin as IsCurrentPageProvider).pageLabel;
  @override
  bool Function(PageLabel, ViewMode)? get handler =>
      (origin as IsCurrentPageProvider).handler;
}

String _$proxiesActionsStateHash() =>
    r'931a3ece44732522c3e3804f940522bea748931f';

/// See also [proxiesActionsState].
@ProviderFor(proxiesActionsState)
final proxiesActionsStateProvider =
    AutoDisposeProvider<ProxiesActionsState>.internal(
  proxiesActionsState,
  name: r'proxiesActionsStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$proxiesActionsStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProxiesActionsStateRef = AutoDisposeProviderRef<ProxiesActionsState>;
String _$startButtonSelectorStateHash() =>
    r'fadbbc8f063444d3c221b9dcd50f636ded38f2af';

/// See also [startButtonSelectorState].
@ProviderFor(startButtonSelectorState)
final startButtonSelectorStateProvider =
    AutoDisposeProvider<StartButtonSelectorState>.internal(
  startButtonSelectorState,
  name: r'startButtonSelectorStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$startButtonSelectorStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef StartButtonSelectorStateRef
    = AutoDisposeProviderRef<StartButtonSelectorState>;
String _$profilesSelectorStateHash() =>
    r'9fa4447dace0322e888efb38cbee1dabd33e0e71';

/// See also [profilesSelectorState].
@ProviderFor(profilesSelectorState)
final profilesSelectorStateProvider =
    AutoDisposeProvider<ProfilesSelectorState>.internal(
  profilesSelectorState,
  name: r'profilesSelectorStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profilesSelectorStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfilesSelectorStateRef
    = AutoDisposeProviderRef<ProfilesSelectorState>;
String _$navigationsHash() => r'09270afa940238ce49a0683989a2ac31d4ad92ad';

/// See also [navigations].
@ProviderFor(navigations)
final navigationsProvider = AutoDisposeProvider<List<NavigationItem>>.internal(
  navigations,
  name: r'navigationsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$navigationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NavigationsRef = AutoDisposeProviderRef<List<NavigationItem>>;
String _$currentNavigationsHash() =>
    r'c5b85dfaf045803381150870337170b703c46489';

/// See also [currentNavigations].
@ProviderFor(currentNavigations)
final currentNavigationsProvider =
    AutoDisposeProvider<List<NavigationItem>>.internal(
  currentNavigations,
  name: r'currentNavigationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentNavigationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentNavigationsRef = AutoDisposeProviderRef<List<NavigationItem>>;
String _$getRealTestUrlHash() => r'5c6513cabb53e5e6689cba5919f49aeaeff90247';

/// See also [getRealTestUrl].
@ProviderFor(getRealTestUrl)
const getRealTestUrlProvider = GetRealTestUrlFamily();

/// See also [getRealTestUrl].
class GetRealTestUrlFamily extends Family<String> {
  /// See also [getRealTestUrl].
  const GetRealTestUrlFamily();

  /// See also [getRealTestUrl].
  GetRealTestUrlProvider call([
    String? testUrl,
  ]) {
    return GetRealTestUrlProvider(
      testUrl,
    );
  }

  @override
  GetRealTestUrlProvider getProviderOverride(
    covariant GetRealTestUrlProvider provider,
  ) {
    return call(
      provider.testUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getRealTestUrlProvider';
}

/// See also [getRealTestUrl].
class GetRealTestUrlProvider extends AutoDisposeProvider<String> {
  /// See also [getRealTestUrl].
  GetRealTestUrlProvider([
    String? testUrl,
  ]) : this._internal(
          (ref) => getRealTestUrl(
            ref as GetRealTestUrlRef,
            testUrl,
          ),
          from: getRealTestUrlProvider,
          name: r'getRealTestUrlProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRealTestUrlHash,
          dependencies: GetRealTestUrlFamily._dependencies,
          allTransitiveDependencies:
              GetRealTestUrlFamily._allTransitiveDependencies,
          testUrl: testUrl,
        );

  GetRealTestUrlProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.testUrl,
  }) : super.internal();

  final String? testUrl;

  @override
  Override overrideWith(
    String Function(GetRealTestUrlRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRealTestUrlProvider._internal(
        (ref) => create(ref as GetRealTestUrlRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        testUrl: testUrl,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _GetRealTestUrlProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRealTestUrlProvider && other.testUrl == testUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, testUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetRealTestUrlRef on AutoDisposeProviderRef<String> {
  /// The parameter `testUrl` of this provider.
  String? get testUrl;
}

class _GetRealTestUrlProviderElement extends AutoDisposeProviderElement<String>
    with GetRealTestUrlRef {
  _GetRealTestUrlProviderElement(super.provider);

  @override
  String? get testUrl => (origin as GetRealTestUrlProvider).testUrl;
}

String _$getDelayHash() => r'eb10238499e73cfa664f0033b119f8933746ee70';

/// See also [getDelay].
@ProviderFor(getDelay)
const getDelayProvider = GetDelayFamily();

/// See also [getDelay].
class GetDelayFamily extends Family<int?> {
  /// See also [getDelay].
  const GetDelayFamily();

  /// See also [getDelay].
  GetDelayProvider call({
    required String proxyName,
    String? testUrl,
  }) {
    return GetDelayProvider(
      proxyName: proxyName,
      testUrl: testUrl,
    );
  }

  @override
  GetDelayProvider getProviderOverride(
    covariant GetDelayProvider provider,
  ) {
    return call(
      proxyName: provider.proxyName,
      testUrl: provider.testUrl,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getDelayProvider';
}

/// See also [getDelay].
class GetDelayProvider extends AutoDisposeProvider<int?> {
  /// See also [getDelay].
  GetDelayProvider({
    required String proxyName,
    String? testUrl,
  }) : this._internal(
          (ref) => getDelay(
            ref as GetDelayRef,
            proxyName: proxyName,
            testUrl: testUrl,
          ),
          from: getDelayProvider,
          name: r'getDelayProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getDelayHash,
          dependencies: GetDelayFamily._dependencies,
          allTransitiveDependencies: GetDelayFamily._allTransitiveDependencies,
          proxyName: proxyName,
          testUrl: testUrl,
        );

  GetDelayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.proxyName,
    required this.testUrl,
  }) : super.internal();

  final String proxyName;
  final String? testUrl;

  @override
  Override overrideWith(
    int? Function(GetDelayRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetDelayProvider._internal(
        (ref) => create(ref as GetDelayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        proxyName: proxyName,
        testUrl: testUrl,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int?> createElement() {
    return _GetDelayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetDelayProvider &&
        other.proxyName == proxyName &&
        other.testUrl == testUrl;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, proxyName.hashCode);
    hash = _SystemHash.combine(hash, testUrl.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetDelayRef on AutoDisposeProviderRef<int?> {
  /// The parameter `proxyName` of this provider.
  String get proxyName;

  /// The parameter `testUrl` of this provider.
  String? get testUrl;
}

class _GetDelayProviderElement extends AutoDisposeProviderElement<int?>
    with GetDelayRef {
  _GetDelayProviderElement(super.provider);

  @override
  String get proxyName => (origin as GetDelayProvider).proxyName;
  @override
  String? get testUrl => (origin as GetDelayProvider).testUrl;
}

String _$selectedMapHash() => r'0d7a3610d9005e74e1a88595d7e22897dc8240a5';

/// See also [selectedMap].
@ProviderFor(selectedMap)
final selectedMapProvider = AutoDisposeProvider<SelectedMap>.internal(
  selectedMap,
  name: r'selectedMapProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$selectedMapHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SelectedMapRef = AutoDisposeProviderRef<SelectedMap>;
String _$currentProfileHash() => r'55f3cb9570a0aa6b9e0b83a36693b69d52e753ab';

/// See also [currentProfile].
@ProviderFor(currentProfile)
final currentProfileProvider = AutoDisposeProvider<Profile?>.internal(
  currentProfile,
  name: r'currentProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentProfileRef = AutoDisposeProviderRef<Profile?>;
String _$getProxiesColumnsHash() => r'895705381fe361fa40f16da2f9cb26e8da3293e8';

/// See also [getProxiesColumns].
@ProviderFor(getProxiesColumns)
final getProxiesColumnsProvider = AutoDisposeProvider<int>.internal(
  getProxiesColumns,
  name: r'getProxiesColumnsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getProxiesColumnsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProxiesColumnsRef = AutoDisposeProviderRef<int>;
String _$getRealProxyNameHash() => r'47be6d115aa170f9bff610ec2cf7669e168bf472';

/// See also [getRealProxyName].
@ProviderFor(getRealProxyName)
const getRealProxyNameProvider = GetRealProxyNameFamily();

/// See also [getRealProxyName].
class GetRealProxyNameFamily extends Family<String> {
  /// See also [getRealProxyName].
  const GetRealProxyNameFamily();

  /// See also [getRealProxyName].
  GetRealProxyNameProvider call(
    String proxyName,
  ) {
    return GetRealProxyNameProvider(
      proxyName,
    );
  }

  @override
  GetRealProxyNameProvider getProviderOverride(
    covariant GetRealProxyNameProvider provider,
  ) {
    return call(
      provider.proxyName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getRealProxyNameProvider';
}

/// See also [getRealProxyName].
class GetRealProxyNameProvider extends AutoDisposeProvider<String> {
  /// See also [getRealProxyName].
  GetRealProxyNameProvider(
    String proxyName,
  ) : this._internal(
          (ref) => getRealProxyName(
            ref as GetRealProxyNameRef,
            proxyName,
          ),
          from: getRealProxyNameProvider,
          name: r'getRealProxyNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getRealProxyNameHash,
          dependencies: GetRealProxyNameFamily._dependencies,
          allTransitiveDependencies:
              GetRealProxyNameFamily._allTransitiveDependencies,
          proxyName: proxyName,
        );

  GetRealProxyNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.proxyName,
  }) : super.internal();

  final String proxyName;

  @override
  Override overrideWith(
    String Function(GetRealProxyNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetRealProxyNameProvider._internal(
        (ref) => create(ref as GetRealProxyNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        proxyName: proxyName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _GetRealProxyNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetRealProxyNameProvider && other.proxyName == proxyName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, proxyName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetRealProxyNameRef on AutoDisposeProviderRef<String> {
  /// The parameter `proxyName` of this provider.
  String get proxyName;
}

class _GetRealProxyNameProviderElement
    extends AutoDisposeProviderElement<String> with GetRealProxyNameRef {
  _GetRealProxyNameProviderElement(super.provider);

  @override
  String get proxyName => (origin as GetRealProxyNameProvider).proxyName;
}

String _$getProxyNameHash() => r'204a477ea18c8e1eeef55b3efd3d47e45b0d2350';

/// See also [getProxyName].
@ProviderFor(getProxyName)
const getProxyNameProvider = GetProxyNameFamily();

/// See also [getProxyName].
class GetProxyNameFamily extends Family<String?> {
  /// See also [getProxyName].
  const GetProxyNameFamily();

  /// See also [getProxyName].
  GetProxyNameProvider call(
    String groupName,
  ) {
    return GetProxyNameProvider(
      groupName,
    );
  }

  @override
  GetProxyNameProvider getProviderOverride(
    covariant GetProxyNameProvider provider,
  ) {
    return call(
      provider.groupName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getProxyNameProvider';
}

/// See also [getProxyName].
class GetProxyNameProvider extends AutoDisposeProvider<String?> {
  /// See also [getProxyName].
  GetProxyNameProvider(
    String groupName,
  ) : this._internal(
          (ref) => getProxyName(
            ref as GetProxyNameRef,
            groupName,
          ),
          from: getProxyNameProvider,
          name: r'getProxyNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProxyNameHash,
          dependencies: GetProxyNameFamily._dependencies,
          allTransitiveDependencies:
              GetProxyNameFamily._allTransitiveDependencies,
          groupName: groupName,
        );

  GetProxyNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupName,
  }) : super.internal();

  final String groupName;

  @override
  Override overrideWith(
    String? Function(GetProxyNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProxyNameProvider._internal(
        (ref) => create(ref as GetProxyNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupName: groupName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String?> createElement() {
    return _GetProxyNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProxyNameProvider && other.groupName == groupName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetProxyNameRef on AutoDisposeProviderRef<String?> {
  /// The parameter `groupName` of this provider.
  String get groupName;
}

class _GetProxyNameProviderElement extends AutoDisposeProviderElement<String?>
    with GetProxyNameRef {
  _GetProxyNameProviderElement(super.provider);

  @override
  String get groupName => (origin as GetProxyNameProvider).groupName;
}

String _$getSelectedProxyNameHash() =>
    r'13aeae1fede234983d262d824a85c7375f9e4e78';

/// See also [getSelectedProxyName].
@ProviderFor(getSelectedProxyName)
const getSelectedProxyNameProvider = GetSelectedProxyNameFamily();

/// See also [getSelectedProxyName].
class GetSelectedProxyNameFamily extends Family<String?> {
  /// See also [getSelectedProxyName].
  const GetSelectedProxyNameFamily();

  /// See also [getSelectedProxyName].
  GetSelectedProxyNameProvider call(
    String groupName,
  ) {
    return GetSelectedProxyNameProvider(
      groupName,
    );
  }

  @override
  GetSelectedProxyNameProvider getProviderOverride(
    covariant GetSelectedProxyNameProvider provider,
  ) {
    return call(
      provider.groupName,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getSelectedProxyNameProvider';
}

/// See also [getSelectedProxyName].
class GetSelectedProxyNameProvider extends AutoDisposeProvider<String?> {
  /// See also [getSelectedProxyName].
  GetSelectedProxyNameProvider(
    String groupName,
  ) : this._internal(
          (ref) => getSelectedProxyName(
            ref as GetSelectedProxyNameRef,
            groupName,
          ),
          from: getSelectedProxyNameProvider,
          name: r'getSelectedProxyNameProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSelectedProxyNameHash,
          dependencies: GetSelectedProxyNameFamily._dependencies,
          allTransitiveDependencies:
              GetSelectedProxyNameFamily._allTransitiveDependencies,
          groupName: groupName,
        );

  GetSelectedProxyNameProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.groupName,
  }) : super.internal();

  final String groupName;

  @override
  Override overrideWith(
    String? Function(GetSelectedProxyNameRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetSelectedProxyNameProvider._internal(
        (ref) => create(ref as GetSelectedProxyNameRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        groupName: groupName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String?> createElement() {
    return _GetSelectedProxyNameProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetSelectedProxyNameProvider &&
        other.groupName == groupName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, groupName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetSelectedProxyNameRef on AutoDisposeProviderRef<String?> {
  /// The parameter `groupName` of this provider.
  String get groupName;
}

class _GetSelectedProxyNameProviderElement
    extends AutoDisposeProviderElement<String?> with GetSelectedProxyNameRef {
  _GetSelectedProxyNameProviderElement(super.provider);

  @override
  String get groupName => (origin as GetSelectedProxyNameProvider).groupName;
}

String _$getProxyDescHash() => r'7c06402957387c35d9dc515ca109f8f7dbb481b0';

/// See also [getProxyDesc].
@ProviderFor(getProxyDesc)
const getProxyDescProvider = GetProxyDescFamily();

/// See also [getProxyDesc].
class GetProxyDescFamily extends Family<String> {
  /// See also [getProxyDesc].
  const GetProxyDescFamily();

  /// See also [getProxyDesc].
  GetProxyDescProvider call(
    Proxy proxy,
  ) {
    return GetProxyDescProvider(
      proxy,
    );
  }

  @override
  GetProxyDescProvider getProviderOverride(
    covariant GetProxyDescProvider provider,
  ) {
    return call(
      provider.proxy,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getProxyDescProvider';
}

/// See also [getProxyDesc].
class GetProxyDescProvider extends AutoDisposeProvider<String> {
  /// See also [getProxyDesc].
  GetProxyDescProvider(
    Proxy proxy,
  ) : this._internal(
          (ref) => getProxyDesc(
            ref as GetProxyDescRef,
            proxy,
          ),
          from: getProxyDescProvider,
          name: r'getProxyDescProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getProxyDescHash,
          dependencies: GetProxyDescFamily._dependencies,
          allTransitiveDependencies:
              GetProxyDescFamily._allTransitiveDependencies,
          proxy: proxy,
        );

  GetProxyDescProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.proxy,
  }) : super.internal();

  final Proxy proxy;

  @override
  Override overrideWith(
    String Function(GetProxyDescRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetProxyDescProvider._internal(
        (ref) => create(ref as GetProxyDescRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        proxy: proxy,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<String> createElement() {
    return _GetProxyDescProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetProxyDescProvider && other.proxy == proxy;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, proxy.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetProxyDescRef on AutoDisposeProviderRef<String> {
  /// The parameter `proxy` of this provider.
  Proxy get proxy;
}

class _GetProxyDescProviderElement extends AutoDisposeProviderElement<String>
    with GetProxyDescRef {
  _GetProxyDescProviderElement(super.provider);

  @override
  Proxy get proxy => (origin as GetProxyDescProvider).proxy;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
