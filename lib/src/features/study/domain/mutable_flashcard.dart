import 'dart:math';

import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';
import 'package:flashcard_pet/src/features/study/presentation/flashcard_study_screen.dart';

extension MutableFlashcard on Flashcard {
  // This algorithm follows the Super Memo 2 Spaced Repetition algorithm found online, adapted to fit 3 answer choices instead of 5.
  Flashcard setNextReview(AnswerChoice answerChoice, DateTime? examDate) {
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

    DateTime? nextDueDate = DateTime.now().add(Duration(days: newInterval));
    if (examDate != null && nextDueDate.isAfter(examDate)) {
      nextDueDate = null;
    }

    return copyWith(
      nextDueDate: nextDueDate,
      reviewCount: reviewCount + 1,
      easeFactor: newEaseFactor,
      previousInterval: newInterval,
    );
  }
}
