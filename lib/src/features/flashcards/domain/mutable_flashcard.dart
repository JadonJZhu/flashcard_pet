import 'dart:math';

import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_screen.dart';

extension MutableFlashcard on Flashcard {
  Flashcard setNextReview(AnswerChoice answerChoice) {
    int quality;
    int newInterval;

    switch (answerChoice) {
      case AnswerChoice.easy:
        quality = 5;
        break;
      case AnswerChoice.difficult:
        quality = 3;
        break;
      case AnswerChoice.forgot:
        quality = 0;
        break;
    }

    // Calculate new ease factor
    double newEaseFactor = max(1.3,
        easeFactor + (0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)));

    // Calculate new interval
    if (reviewCount == 0) {
      newInterval = 1;
    } else if (reviewCount == 1) {
      newInterval = 6;
    } else {
      newInterval = (previousInterval! * newEaseFactor).round();
    }

    // Adjust interval based on quality
    if (quality < 3) {
      newInterval = 1;
    } else if (quality == 3) {
      newInterval = previousInterval == null
          ? newInterval
          : max(newInterval, previousInterval! + 1);
    }

    return copyWith(
      nextDueDate: DateTime.now().add(Duration(days: newInterval)),
      reviewCount: reviewCount + 1,
      easeFactor: newEaseFactor,
      previousInterval: newInterval,
    );
  }
}
