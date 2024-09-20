/// Dummy to be used until a data source is implemented
library;

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill/quill_delta.dart' as quill_delta;

const Map<DeckID, Deck> kDummyDecksMap = {
  '1': Deck(
    id: '1',
    title: "Deck 1",
  ),
};

final Map<FlashcardID, Flashcard> kDummyFlashcardsMap = {
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
    backContent: quill.Document.fromDelta(quill_delta.Delta()
      ..insert('Hello, ')
      ..insert(
        'world2!!!',
        {'bold': true},
      )
      ..insert('!\n')),
      nextDueDate: DateTime(2024, 9, 11),
  ),
  '2': Flashcard(
    id: '2',
    deckId: '1',
    frontContent: quill.Document(),
    backContent: quill.Document(),
    nextDueDate: DateTime.now(),
  ),
};

// - refactor flashcard study to get rid of complex controller
// - use stateful widgets when controllers get too complex
// - use controllers for asynchronous callbacks 