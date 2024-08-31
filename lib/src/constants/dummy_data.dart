/// Dummy to be used until a data source is implemented
library;

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';

const Map<DeckID, Deck> kDecks = {
  '1': Deck(
    id: '1',
    title: "Deck 1",
  ),
};

const Map<FlashcardID, Flashcard> kFlashcards = {
  '1': Flashcard(
    id: '1',
    deckId: '1',
    front: 'excessively long flashcard naaaaaaaaaaaaaaaaaaaaaaaaaaaaaame',
    back: 'back',
  ),
  '2': Flashcard(
    id: '2',
    deckId: '1',
    front: 'flashcard front 2',
    back: 'flashcard back 2®',
  ),
};
