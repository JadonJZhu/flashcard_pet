import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';

class StudyFlashcardState {
  StudyFlashcardState({
    required this.currentCard,
    required this.remainingCount,
    required this.isFlipped,
  });

  final Flashcard? currentCard;
  final int remainingCount;
  final bool isFlipped;


  factory StudyFlashcardState.initial() => StudyFlashcardState(
        currentCard: null,
        remainingCount: 0,
        isFlipped: false,
      );

  StudyFlashcardState copyWith({
    Flashcard? currentCard,
    int? remainingCount,
    bool? isFlipped,
  }) {
    return StudyFlashcardState(
      currentCard: currentCard ?? this.currentCard,
      remainingCount: remainingCount ?? this.remainingCount,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}
