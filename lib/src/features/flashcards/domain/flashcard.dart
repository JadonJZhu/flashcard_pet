import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

typedef FlashcardID = String;

class Flashcard {
  const Flashcard({
    required this.id,
    required this.deckId,
    required this.frontContent,
    required this.backContent,
  });

  final FlashcardID id;
  final DeckID deckId;
  final quill.Document frontContent;
  final quill.Document backContent;

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      id: json['id'] as String,
      deckId: json['deckId'] as String,
      frontContent: quill.Document.fromJson(json['frontContent']),
      backContent: quill.Document.fromJson(json['backContent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deckId': deckId,
      'frontContent': frontContent.toDelta().toJson(),
      'backContent': backContent.toDelta().toJson(),
    };
  }
}
