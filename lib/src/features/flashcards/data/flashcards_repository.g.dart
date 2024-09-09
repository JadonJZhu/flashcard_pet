// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcards_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$flashcardsRepositoryHash() =>
    r'dd3e3a477be524ebbb2e589dfbfbb403fac9c08d';

/// See also [flashcardsRepository].
@ProviderFor(flashcardsRepository)
final flashcardsRepositoryProvider = Provider<FlashcardsRepository>.internal(
  flashcardsRepository,
  name: r'flashcardsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashcardsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlashcardsRepositoryRef = ProviderRef<FlashcardsRepository>;
String _$flashcardsStreamHash() => r'50c5bf5ce7b286ebdc6f68d02d1f2ed026171a9f';

/// See also [flashcardsStream].
@ProviderFor(flashcardsStream)
final flashcardsStreamProvider =
    AutoDisposeStreamProvider<List<Flashcard>>.internal(
  flashcardsStream,
  name: r'flashcardsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$flashcardsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FlashcardsStreamRef = AutoDisposeStreamProviderRef<List<Flashcard>>;
String _$flashcardByIdStreamHash() =>
    r'0922efbf4cfea9a080377a0654ddc921102fc2db';

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

/// See also [flashcardByIdStream].
@ProviderFor(flashcardByIdStream)
const flashcardByIdStreamProvider = FlashcardByIdStreamFamily();

/// See also [flashcardByIdStream].
class FlashcardByIdStreamFamily extends Family<AsyncValue<Flashcard?>> {
  /// See also [flashcardByIdStream].
  const FlashcardByIdStreamFamily();

  /// See also [flashcardByIdStream].
  FlashcardByIdStreamProvider call(
    String flashcardId,
  ) {
    return FlashcardByIdStreamProvider(
      flashcardId,
    );
  }

  @override
  FlashcardByIdStreamProvider getProviderOverride(
    covariant FlashcardByIdStreamProvider provider,
  ) {
    return call(
      provider.flashcardId,
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
  String? get name => r'flashcardByIdStreamProvider';
}

/// See also [flashcardByIdStream].
class FlashcardByIdStreamProvider
    extends AutoDisposeStreamProvider<Flashcard?> {
  /// See also [flashcardByIdStream].
  FlashcardByIdStreamProvider(
    String flashcardId,
  ) : this._internal(
          (ref) => flashcardByIdStream(
            ref as FlashcardByIdStreamRef,
            flashcardId,
          ),
          from: flashcardByIdStreamProvider,
          name: r'flashcardByIdStreamProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flashcardByIdStreamHash,
          dependencies: FlashcardByIdStreamFamily._dependencies,
          allTransitiveDependencies:
              FlashcardByIdStreamFamily._allTransitiveDependencies,
          flashcardId: flashcardId,
        );

  FlashcardByIdStreamProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flashcardId,
  }) : super.internal();

  final String flashcardId;

  @override
  Override overrideWith(
    Stream<Flashcard?> Function(FlashcardByIdStreamRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardByIdStreamProvider._internal(
        (ref) => create(ref as FlashcardByIdStreamRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flashcardId: flashcardId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Flashcard?> createElement() {
    return _FlashcardByIdStreamProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardByIdStreamProvider &&
        other.flashcardId == flashcardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flashcardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FlashcardByIdStreamRef on AutoDisposeStreamProviderRef<Flashcard?> {
  /// The parameter `flashcardId` of this provider.
  String get flashcardId;
}

class _FlashcardByIdStreamProviderElement
    extends AutoDisposeStreamProviderElement<Flashcard?>
    with FlashcardByIdStreamRef {
  _FlashcardByIdStreamProviderElement(super.provider);

  @override
  String get flashcardId => (origin as FlashcardByIdStreamProvider).flashcardId;
}

String _$flashcardByIdFutureHash() =>
    r'98fb8af7573836eddf2b981f25c940c64e1a306d';

/// See also [flashcardByIdFuture].
@ProviderFor(flashcardByIdFuture)
const flashcardByIdFutureProvider = FlashcardByIdFutureFamily();

/// See also [flashcardByIdFuture].
class FlashcardByIdFutureFamily extends Family<AsyncValue<Flashcard?>> {
  /// See also [flashcardByIdFuture].
  const FlashcardByIdFutureFamily();

  /// See also [flashcardByIdFuture].
  FlashcardByIdFutureProvider call(
    String flashcardId,
  ) {
    return FlashcardByIdFutureProvider(
      flashcardId,
    );
  }

  @override
  FlashcardByIdFutureProvider getProviderOverride(
    covariant FlashcardByIdFutureProvider provider,
  ) {
    return call(
      provider.flashcardId,
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
  String? get name => r'flashcardByIdFutureProvider';
}

/// See also [flashcardByIdFuture].
class FlashcardByIdFutureProvider
    extends AutoDisposeFutureProvider<Flashcard?> {
  /// See also [flashcardByIdFuture].
  FlashcardByIdFutureProvider(
    String flashcardId,
  ) : this._internal(
          (ref) => flashcardByIdFuture(
            ref as FlashcardByIdFutureRef,
            flashcardId,
          ),
          from: flashcardByIdFutureProvider,
          name: r'flashcardByIdFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flashcardByIdFutureHash,
          dependencies: FlashcardByIdFutureFamily._dependencies,
          allTransitiveDependencies:
              FlashcardByIdFutureFamily._allTransitiveDependencies,
          flashcardId: flashcardId,
        );

  FlashcardByIdFutureProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.flashcardId,
  }) : super.internal();

  final String flashcardId;

  @override
  Override overrideWith(
    FutureOr<Flashcard?> Function(FlashcardByIdFutureRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardByIdFutureProvider._internal(
        (ref) => create(ref as FlashcardByIdFutureRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        flashcardId: flashcardId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Flashcard?> createElement() {
    return _FlashcardByIdFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardByIdFutureProvider &&
        other.flashcardId == flashcardId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, flashcardId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FlashcardByIdFutureRef on AutoDisposeFutureProviderRef<Flashcard?> {
  /// The parameter `flashcardId` of this provider.
  String get flashcardId;
}

class _FlashcardByIdFutureProviderElement
    extends AutoDisposeFutureProviderElement<Flashcard?>
    with FlashcardByIdFutureRef {
  _FlashcardByIdFutureProviderElement(super.provider);

  @override
  String get flashcardId => (origin as FlashcardByIdFutureProvider).flashcardId;
}

String _$flashcardsByDeckFutureHash() =>
    r'9b42aa1139eed99e6b532e1ed24c17da2c210588';

/// See also [flashcardsByDeckFuture].
@ProviderFor(flashcardsByDeckFuture)
const flashcardsByDeckFutureProvider = FlashcardsByDeckFutureFamily();

/// See also [flashcardsByDeckFuture].
class FlashcardsByDeckFutureFamily extends Family<AsyncValue<List<Flashcard>>> {
  /// See also [flashcardsByDeckFuture].
  const FlashcardsByDeckFutureFamily();

  /// See also [flashcardsByDeckFuture].
  FlashcardsByDeckFutureProvider call(
    String deckId,
  ) {
    return FlashcardsByDeckFutureProvider(
      deckId,
    );
  }

  @override
  FlashcardsByDeckFutureProvider getProviderOverride(
    covariant FlashcardsByDeckFutureProvider provider,
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
  String? get name => r'flashcardsByDeckFutureProvider';
}

/// See also [flashcardsByDeckFuture].
class FlashcardsByDeckFutureProvider
    extends AutoDisposeFutureProvider<List<Flashcard>> {
  /// See also [flashcardsByDeckFuture].
  FlashcardsByDeckFutureProvider(
    String deckId,
  ) : this._internal(
          (ref) => flashcardsByDeckFuture(
            ref as FlashcardsByDeckFutureRef,
            deckId,
          ),
          from: flashcardsByDeckFutureProvider,
          name: r'flashcardsByDeckFutureProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$flashcardsByDeckFutureHash,
          dependencies: FlashcardsByDeckFutureFamily._dependencies,
          allTransitiveDependencies:
              FlashcardsByDeckFutureFamily._allTransitiveDependencies,
          deckId: deckId,
        );

  FlashcardsByDeckFutureProvider._internal(
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
    FutureOr<List<Flashcard>> Function(FlashcardsByDeckFutureRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FlashcardsByDeckFutureProvider._internal(
        (ref) => create(ref as FlashcardsByDeckFutureRef),
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
  AutoDisposeFutureProviderElement<List<Flashcard>> createElement() {
    return _FlashcardsByDeckFutureProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FlashcardsByDeckFutureProvider && other.deckId == deckId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, deckId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FlashcardsByDeckFutureRef
    on AutoDisposeFutureProviderRef<List<Flashcard>> {
  /// The parameter `deckId` of this provider.
  String get deckId;
}

class _FlashcardsByDeckFutureProviderElement
    extends AutoDisposeFutureProviderElement<List<Flashcard>>
    with FlashcardsByDeckFutureRef {
  _FlashcardsByDeckFutureProviderElement(super.provider);

  @override
  String get deckId => (origin as FlashcardsByDeckFutureProvider).deckId;
}

String _$dueFlashcardsStreamHash() =>
    r'1b3f76fe9af768dd8858bbf4c45ee4f03086d553';

/// See also [dueFlashcardsStream].
@ProviderFor(dueFlashcardsStream)
final dueFlashcardsStreamProvider =
    AutoDisposeStreamProvider<List<Flashcard>>.internal(
  dueFlashcardsStream,
  name: r'dueFlashcardsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dueFlashcardsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DueFlashcardsStreamRef = AutoDisposeStreamProviderRef<List<Flashcard>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
