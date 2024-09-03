/// Dummy to be used until a data source is implemented
library;

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as quill_delta;

const Map<DeckID, Deck> kDecks = {
  '1': Deck(
    id: '1',
    title: "Deck 1",
  ),
};

final Map<FlashcardID, Flashcard> kFlashcards = {
  '1': Flashcard(
    id: '1',
    deckId: '1',
    frontContent: quill.Document.fromDelta(quill_delta.Delta()
      ..insert('Hello, ')
      ..insert(
        'world',
        {'bold': true},
      )
      ..insert('!\n')),
    backContent: quill.Document.fromDelta(
      quill_delta.Delta()
        ..insert('Hello, ')
        ..insert('world2', {quill.Attribute.bold.key: true})
        ..insert('!\n'),
    ),
  ),
  '2': Flashcard(
    id: '2',
    deckId: '1',
    frontContent: quill.Document(),
    backContent: quill.Document(),
  ),
};

