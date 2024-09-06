import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';

part 'deck_editor_controller.g.dart';

@riverpod
class DeckEditorController extends _$DeckEditorController {
  @override
  FutureOr<void> build() async {
    // no-op
  }

  Future<void> saveDeck({
    required Deck deck,
    required List<Flashcard> cardsToUpdate,
    required List<FlashcardID> deletedCardsIds,
  }) async {
    
    state = const AsyncLoading();

    try {
      await ref.read(decksRepositoryProvider).setDeck(deck);
      await ref.read(flashcardsRepositoryProvider).setFlashcards(cardsToUpdate);
      await ref
          .read(studyFlashcardServiceProvider)
          .deleteFlashcardsById(deletedCardsIds);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteDeck(DeckID deckId) async {
    state = const AsyncLoading();

    try {
      await ref
          .read(studyFlashcardServiceProvider)
          .deleteFlashcardsByDeckId(deckId);

      await ref.read(decksRepositoryProvider).deleteDeckById(deckId);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
