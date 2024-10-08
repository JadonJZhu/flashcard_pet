import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/study/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/fake_async_util.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';
import 'package:rxdart/rxdart.dart';

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
  Stream<List<Flashcard>> watchFlashcardsByDueDate(DateTime date) {
    final hourlyTicker =
        Stream<void>.periodic(const Duration(hours: 1)).startWith(null);

    // Combine the flashcards stream with the hourly ticker
    return Rx.combineLatest2(
      _flashcards.stream,
      hourlyTicker,
      (flashcardsMap, _) {
        return flashcardsMap.values
            .where((flashcard) => flashcard.nextDueDate.isAtSameMomentAs(date))
            .toList();
      },
    );
  }

  @override
  Stream<List<Flashcard>> watchDueFlashcards() {
    final hourlyTicker =
        Stream<void>.periodic(const Duration(hours: 1)).startWith(null);

    // Combine the flashcards stream with the hourly ticker
    return Rx.combineLatest2(
      _flashcards.stream,
      hourlyTicker,
      (flashcardsMap, _) {
        final now = DateTime.now();
        return flashcardsMap.values
            .where((flashcard) => flashcard.nextDueDate.isBefore(now))
            .toList();
      },
    );
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

  @override
  Future<void> deleteFlashcardsByDeckId(DeckID id) async {
    await fakeAsyncMutationCallback(
        inMemoryStore: _flashcards,
        callback: (flashcards) {
          flashcards.removeWhere((_, flashcard) => flashcard.deckId == id);
        });
  }
}
