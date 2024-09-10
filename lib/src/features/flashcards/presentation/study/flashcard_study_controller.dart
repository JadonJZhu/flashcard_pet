import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/mutable_flashcard.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_screen.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashcard_study_controller.g.dart';

@riverpod
class FlashcardStudyController extends _$FlashcardStudyController {
  @override
  Future<FlashcardStudyState> build() async {
    final flashcards = await ref.watch(dueFlashcardsStreamProvider.future);

    return FlashcardStudyState(
      currentCard: flashcards.firstOrNull,
      remainingCount: flashcards.length,
      isFlipped: false,
    );
  }

  void flipCard() {
    state = AsyncValue.data(
        state.value!.copyWith(isFlipped: !state.value!.isFlipped));
  }

  Future<void> answer(Flashcard card, AnswerChoice answerChoice) async {
    final updatedCard = card.setNextReview(answerChoice);

    state = const AsyncLoading();
    final successState = await AsyncValue.guard(
        () => ref.read(flashcardsRepositoryProvider).setFlashcard(updatedCard));
    if (successState.hasError) {
      state = AsyncError(successState.error!, successState.stackTrace!);
    } else {
      state = AsyncData(state.value!);
    }
  }
}

class FlashcardStudyState {
  FlashcardStudyState({
    required this.currentCard,
    required this.remainingCount,
    required this.isFlipped,
  });

  final Flashcard? currentCard;
  final int remainingCount;
  final bool isFlipped;

  factory FlashcardStudyState.initial() => FlashcardStudyState(
        currentCard: null,
        remainingCount: 0,
        isFlipped: false,
      );

  FlashcardStudyState copyWith({
    Flashcard? currentCard,
    int? remainingCount,
    bool? isFlipped,
  }) {
    return FlashcardStudyState(
      currentCard: currentCard ?? this.currentCard,
      remainingCount: remainingCount ?? this.remainingCount,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}
