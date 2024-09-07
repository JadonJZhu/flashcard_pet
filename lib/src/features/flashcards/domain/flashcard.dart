// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';

typedef FlashcardID = String;

class Flashcard {
  const Flashcard({
    required this.id,
    required this.deckId,
    required this.frontContent,
    required this.backContent,
    required this.nextDueDate
  });

  final FlashcardID id;
  final DeckID deckId;
  final quill.Document frontContent;
  final quill.Document backContent;
  final DateTime nextDueDate;

}
