import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';

typedef DeckID = String;

class Deck {
  const Deck({
    required this.id,
    required this.title,
    required this.flashcardIds,
  });

  final DeckID id;
  final String title;
  final List<FlashcardID> flashcardIds;
}
