import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/study_flashcard_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_flashcard_controller.g.dart';

@riverpod
class StudyFlashcardController extends _$StudyFlashcardController {
  @override
  Future<StudyFlashcardState> build() {
    return _loadInfo();
  }

  Future<StudyFlashcardState> _loadInfo() async {
    debugPrint('controller _loadInfo called');

    final flashcard = await ref.read(flashcardToStudyFutureProvider.future);
    final queueCount = await ref.read(studyQueueCountFutureProvider.future);

    return StudyFlashcardState(
      currentCard: flashcard,
      remainingCount: queueCount,
      isFlipped: false,
    );
  }

  Future<void> loadNextCard() async {
    state = const AsyncLoading();

    final studyFlashcardService = ref.read(studyFlashcardServiceProvider);
    await studyFlashcardService.moveToNextCard();
    state = await AsyncValue.guard(_loadInfo);
  }

  void flipCard() {
    state = AsyncValue.data(
        state.value!.copyWith(isFlipped: !state.value!.isFlipped));
  }
}
