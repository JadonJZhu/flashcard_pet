import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/utils/fake_async_util.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_decks_repository.g.dart';

class FakeDecksRepository {
  FakeDecksRepository({
    this.addDelay = true,
  });

  final bool addDelay;

  final _decksStore = InMemoryStore<Map<DeckID, Deck>>(Map.of(kDummyDecksMap));
  Map<DeckID, Deck> get decksValue => _decksStore.value;

  Stream<List<Deck>> watchDecksList() {
    return _decksStore.stream.map((deckMap) {
      return deckMap.values.toList();
    });
  }

  Stream<Deck?> watchDeckById(DeckID deckId) {
    return _decksStore.stream.map((deckMap) {
      return deckMap[deckId];
    });
  }

  Future<List<Deck>> fetchDecksList() async {
    await delay(addDelay);
    return _decksStore.value.values.toList();
  }

  Future<Deck?> fetchDeckById(DeckID deckId) async {
    await delay(addDelay);
    return _decksStore.value[deckId];
  }

  Future<void> setDeck(Deck deck) async {
    await fakeAsyncMutationCallback(
        inMemoryStore: _decksStore,
        callback: (decks) {
          decks[deck.id] = deck;
        });
  }

  Future<void> deleteDeckById(DeckID deckId) async {
    await fakeAsyncMutationCallback(
      inMemoryStore: _decksStore,
      callback: (decks) => decks.remove(deckId),
    );
  }
}

@riverpod
FakeDecksRepository decksRepository(DecksRepositoryRef ref) {
  return FakeDecksRepository();
}

@riverpod
Stream<List<Deck>> decksListStream(DecksListStreamRef ref) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.watchDecksList();
}

@riverpod
Future<List<Deck>> decksListFuture(DecksListFutureRef ref) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.fetchDecksList();
}

@riverpod
Future<Deck?> deckByIdFuture(DeckByIdFutureRef ref, DeckID deckId) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.fetchDeckById(deckId);
}

@riverpod
Stream<Deck?> deckByIdStream(DeckByIdStreamRef ref, DeckID deckId) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.watchDeckById(deckId);
}