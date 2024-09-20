import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/study/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';

part 'deck_edit_controller.g.dart';

@riverpod
class DeckEditController extends _$DeckEditController {
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
          .read(flashcardsRepositoryProvider)
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
          .read(flashcardsRepositoryProvider)
          .deleteFlashcardsByDeckId(deckId);

      await ref.read(decksRepositoryProvider).deleteDeckById(deckId);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
