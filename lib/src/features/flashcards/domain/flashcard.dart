import 'package:flashcard_pet/src/features/decks/domain/deck.dart';

typedef FlashcardID = String;

class Flashcard {
  const Flashcard({
    required this.id,
    required this.deckId,
    required this.front,
    required this.back,
  });

  final FlashcardID id;
  final DeckID deckId;
  final String front;
  final String back;
}
