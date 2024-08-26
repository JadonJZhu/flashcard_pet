import 'package:flashcard_pet/src/features/flashcards/data/flashcard_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_flashcard_service.g.dart';

class StudyFlashcardService {
  const StudyFlashcardService(this.ref);

  final Ref ref;

  FlashcardsRepository get flashcardsRepository =>
      ref.watch(flashcardsRepositoryProvider);
  StudyQueueRepository get studyQueueRepository =>
      ref.watch(studyQueueRepositoryProvider);

  /*Stream<List<Flashcard>> watchFlashcardsToStudy() {
    return studyQueueRepository.watchFlashcardsIdsToStudy().switchMap(
      (ids) {
        // Create a list of streams, one for each flashcard
        List<Stream<Flashcard?>> cardStreams = ids
            .map((id) => flashcardsRepository.watchFlashcardById(id))
            .toList();

        // Combine the latest values from all streams
        return cardStreams.isEmpty
            ? Stream.value(<Flashcard>[]) // Return empty list if no ids
            : Rx.combineLatest(cardStreams, (List<Flashcard?> cards) {
                // Filter out null values and create a list of non-null Flashcards
                return cards.whereType<Flashcard>().toList();
              });
      },
    );
  }*/

  Future<Flashcard?> fetchFlashcardToStudy() async {
    debugPrint('service watchFlashcardToStudy called');

    final flashcardId = await ref.read(flashcardIdToStudyFutureProvider.future);
    if (flashcardId == null) {
      return null;
    }

    return await ref.read(flashcardByIdFutureProvider(flashcardId).future);
  }

  Future<void> moveToNextCard() async {
    final flashcardId = await studyQueueRepository.popStudyQueue();
    await studyQueueRepository.addFlashcardIdToReviewedQueue(flashcardId);
  }
}

@riverpod
StudyFlashcardService studyFlashcardService(StudyFlashcardServiceRef ref) {
  return StudyFlashcardService(ref);
}

@riverpod
Future<Flashcard?> flashcardToStudyFuture(FlashcardToStudyFutureRef ref) {
  final studyFlashcardsService = ref.watch(studyFlashcardServiceProvider);
  return studyFlashcardsService.fetchFlashcardToStudy();
}
