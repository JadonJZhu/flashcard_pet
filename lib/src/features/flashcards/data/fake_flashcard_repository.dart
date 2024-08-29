import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcard_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/delay.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';

class FakeFlashcardsRepository implements FlashcardsRepository {
  FakeFlashcardsRepository({this.addDelay = true});
  final bool addDelay;

  /// Preload with the default list of flashcards when the app starts
  final _flashcards = InMemoryStore<Map<FlashcardID, Flashcard>>(kFlashcards);

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
    delay(addDelay);
    return _flashcards.value[flashcardId];
  }

  @override
  Future<List<Flashcard>> fetchFlashcardsByDeck(DeckID deckId) async {
    await delay(addDelay);
    return _flashcards.value.values
        .where((flashcard) => flashcard.deckId == deckId).toList();
  }
}
