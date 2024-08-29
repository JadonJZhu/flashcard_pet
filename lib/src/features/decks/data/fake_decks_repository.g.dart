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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
