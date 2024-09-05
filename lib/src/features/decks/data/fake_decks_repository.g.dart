// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fake_decks_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$decksRepositoryHash() => r'd9fe55f5a827b73c4cf312d0c4d08b9d46d19d93';

/// See also [decksRepository].
@ProviderFor(decksRepository)
final decksRepositoryProvider =
    AutoDisposeProvider<FakeDecksRepository>.internal(
  decksRepository,
  name: r'decksRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$decksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DecksRepositoryRef = AutoDisposeProviderRef<FakeDecksRepository>;
String _$decksListStreamHash() => r'48ed70e45c9a1e1553162969e3bb08592803c083';

/// See also [decksListStream].
@ProviderFor(decksListStream)
final decksListStreamProvider = AutoDisposeStreamProvider<List<Deck>>.internal(
  decksListStream,
  name: r'decksListStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$decksListStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DecksListStreamRef = AutoDisposeStreamProviderRef<List<Deck>>;
String _$decksListFutureHash() => r'51bf066478d6efb70a60179e1471ab393c93c8aa';

/// See also [decksListFuture].
@ProviderFor(decksListFuture)
final decksListFutureProvider = AutoDisposeFutureProvider<List<Deck>>.internal(
  decksListFuture,
  name: r'decksListFutureProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$decksListFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DecksListFutureRef = AutoDisposeFutureProviderRef<List<Deck>>;
String _$deckByIdFutureHash() => r'5e6ebaa66cfeab00f0bdf6b49654a7dfbf044883';

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

/// See also [deckByIdFuture].
@ProviderFor(deckByIdFuture)
const deckByIdFutureProvider = DeckByIdFutureFamily();

/// See also [deckByIdFuture].
class DeckByIdFutureFamily extends Family<AsyncValue<Deck?>> {
  /// See also [deckByIdFuture].
  const DeckByIdFutureFamily();

  /// See also [deckByIdFuture].
  DeckByIdFutureProvider call(
    String deckId,
  ) {
    return DeckByIdFutureProvider(
      deckId,
    );
  }

  @override
  DeckByIdFutureProvider getProviderOverride(
    covariant DeckByIdFutureProvider provider,
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
  String? get name => r'deckByIdFutureProvider';
}

/// See also [deckByIdFuture].
class DeckByIdFutureProvider extends AutoDisposeFutureProvider<Deck?> {
  /// See also [deckByIdFuture].
  DeckByIdFutureProvider(
    String deckId,
  ) : this._internal(
          (ref) => deckByIdFuture(
            ref as DeckByIdFutureRef,
            deckId,
          ),
          from: deckByIdFutureProvider,
          name: r'deckByIdFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$deckByIdFutureHash,
          dependencies: DeckByIdFutureFamily._dependencies,
          allTransitiveDependencies:
              DeckByIdFutureFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  DeckByIdFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.deckId,
  }) : super.internal();

  final String deckId;

  @override
  Override overrideWith(
    FutureOr<Deck?> Function(DeckByIdFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DeckByIdFutureProvider._internal(
        (ref) => create(ref as DeckByIdFutureRef),
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
  AutoDisposeFutureProviderElement<Deck?> createElement() {
    return _DeckByIdFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DeckByIdFutureProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DeckByIdFutureRef on AutoDisposeFutureProviderRef<Deck?> {
  /// The parameter `deckId` of this provider.
  String get deckId;
}

class _DeckByIdFutureProviderElement
    extends AutoDisposeFutureProviderElement<Deck?> with DeckByIdFutureRef {
  _DeckByIdFutureProviderElement(super.provider);

  @override
  String get deckId => (origin as DeckByIdFutureProvider).deckId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
