// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_editor_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$deckEditorControllerHash() =>
    r'0f18325ba5c9484427b2b290185e2fa696b4ea8e';

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

abstract class _$DeckEditorController
    extends BuildlessAutoDisposeAsyncNotifier<DeckEditorState> {
  late final String? deckId;

  FutureOr<DeckEditorState> build(
    String? deckId,
  );
}

/// See also [DeckEditorController].
@ProviderFor(DeckEditorController)
const deckEditorControllerProvider = DeckEditorControllerFamily();

/// See also [DeckEditorController].
class DeckEditorControllerFamily extends Family<AsyncValue<DeckEditorState>> {
  /// See also [DeckEditorController].
  const DeckEditorControllerFamily();

  /// See also [DeckEditorController].
  DeckEditorControllerProvider call(
    String? deckId,
  ) {
    return DeckEditorControllerProvider(
      deckId,
    );
  }

  @override
  DeckEditorControllerProvider getProviderOverride(
    covariant DeckEditorControllerProvider provider,
  ) {
    return call(
      provider.deckId,
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
  String? get name => r'deckEditorControllerProvider';
}

/// See also [DeckEditorController].
class DeckEditorControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    DeckEditorController, DeckEditorState> {
  /// See also [DeckEditorController].
  DeckEditorControllerProvider(
    String? deckId,
  ) : this._internal(
          () => DeckEditorController()..deckId = deckId,
          from: deckEditorControllerProvider,
          name: r'deckEditorControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deckEditorControllerHash,
          dependencies: DeckEditorControllerFamily._dependencies,
          allTransitiveDependencies:
              DeckEditorControllerFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  DeckEditorControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final String? deckId;

  @override
  FutureOr<DeckEditorState> runNotifierBuild(
    covariant DeckEditorController notifier,
  ) {
    return notifier.build(
      deckId,
    );
  }

  @override
  Override overrideWith(DeckEditorController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DeckEditorControllerProvider._internal(
        () => create()..deckId = deckId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        deckId: deckId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DeckEditorController, DeckEditorState>
      createElement() {
    return _DeckEditorControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckEditorControllerProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeckEditorControllerRef
    on AutoDisposeAsyncNotifierProviderRef<DeckEditorState> {
  /// The parameter `deckId` of this provider.
  String? get deckId;
}

class _DeckEditorControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<DeckEditorController,
        DeckEditorState> with DeckEditorControllerRef {
  _DeckEditorControllerProviderElement(super.provider);

  @override
  String? get deckId => (origin as DeckEditorControllerProvider).deckId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
