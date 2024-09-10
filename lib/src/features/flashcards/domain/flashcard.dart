import 'package:flutter_quill/flutter_quill.dart' as quill;

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';

typedef FlashcardID = String;

class Flashcard {
  const Flashcard({
    required this.id,
    required this.deckId,
    required this.frontContent,
    required this.backContent,
    required this.nextDueDate,
    this.reviewCount = 0,
    this.easeFactor = 2.5,
    this.previousInterval,
  });

  final FlashcardID id;
  final DeckID deckId;
  final quill.Document frontContent;
  final quill.Document backContent;
  final DateTime nextDueDate;
  final int reviewCount;
  final double easeFactor;
  final int? previousInterval;

  Flashcard copyWith({
    FlashcardID? id,
    DeckID? deckId,
    quill.Document? frontContent,
    quill.Document? backContent,
    DateTime? nextDueDate,
    int? reviewCount,
    double? easeFactor,
    int? previousInterval,
  }) {
    return Flashcard(
      id: id ?? this.id,
      deckId: deckId ?? this.deckId,
      frontContent: frontContent ?? this.frontContent,
      backContent: backContent ?? this.backContent,
      nextDueDate: nextDueDate ?? this.nextDueDate,
      reviewCount: reviewCount ?? this.reviewCount,
      easeFactor: easeFactor ?? this.easeFactor,
      previousInterval: previousInterval ?? this.previousInterval,
    );
  }

  @override
  String toString() {
    return 'Flashcard(id: $id, nextDueDate: $nextDueDate, reviewCount: $reviewCount, easeFactor: $easeFactor)';
  }
}

