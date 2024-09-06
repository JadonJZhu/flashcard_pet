import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/fake_async_util.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';

class FakeFlashcardsRepository implements FlashcardsRepository {
  FakeFlashcardsRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload with the default list of flashcards when the app starts
  final _flashcards =
      InMemoryStore<Map<FlashcardID, Flashcard>>(Map.of(kDummyFlashcardsMap));

  @override
  Stream<List<Flashcard>> watchFlashcards() {
    return _flashcards.stream.map(
      (flashcardsMap) => flashcardsMap.values.toList(),
    );
  }

  @override
  Stream<Flashcard?> watchFlashcardById(FlashcardID flashcardId) {
    return _flashcards.stream
        .map((flashcardsMap) => flashcardsMap[flashcardId]);
  }

  @override
  Future<Flashcard?> fetchFlashcardById(FlashcardID flashcardId) async {
    await delay(addDelay);
    return _flashcards.value[flashcardId];
  }

  @override
  Future<List<Flashcard>> fetchFlashcardsByDeck(DeckID deckId) async {
    await delay(addDelay);
    return _flashcards.value.values
        .where((flashcard) => flashcard.deckId == deckId)
        .toList();
  }

  @override
  Future<void> setFlashcard(Flashcard card) async {
    await fakeAsyncMutationCallback(
      inMemoryStore: _flashcards,
      callback: (flashcards) {
        flashcards[card.id] = card;
      },
    );
  }

  @override
  Future<void> setFlashcards(List<Flashcard> cards) async {
    await fakeAsyncMutationCallback(
      inMemoryStore: _flashcards,
      callback: (flashcards) {
        for (final card in cards) {
          flashcards[card.id] = card;
        }
      },
    );
  }

  @override
  Future<void> deleteFlashcardsById(List<FlashcardID> ids) async {
    await fakeAsyncMutationCallback(
      inMemoryStore: _flashcards,
      callback: (flashcards) {
        for (final id in ids) {
          flashcards.remove(id);
        }
      },
    );
  }
}
