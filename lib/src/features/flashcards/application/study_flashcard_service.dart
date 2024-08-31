import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:rxdart/rxdart.dart';

part 'study_flashcard_service.g.dart';

class StudyFlashcardService {
  const StudyFlashcardService(this.ref);

  final Ref ref;

  FlashcardsRepository get flashcardsRepository =>
      ref.watch(flashcardsRepositoryProvider);
  StudyQueueRepository get studyQueueRepository =>
      ref.watch(studyQueueRepositoryProvider);

  Stream<List<Flashcard>> watchFlashcardsToStudy() {
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
  }

  Future<Flashcard?> fetchFlashcardToStudy() async {
    final flashcardId = await ref.read(flashcardIdToStudyFutureProvider.future);
    if (flashcardId == null) {
      return null;
    }

    return await ref.read(flashcardByIdFutureProvider(flashcardId).future);
  }

  // Stream<Flashcard?> watchFlashcardToStudy() {
  //   final flashcardIdsStream = studyQueueRepository.watchFlashcardsIdsToStudy();

  //   return flashcardIdsStream.switchMap((ids) {
  //     if (ids.isEmpty) {
  //       return Stream.value(null);
  //     }

  //     return flashcardsRepository.watchFlashcardById(ids.first);
  //   });
  // }

  Future<void> moveToNextCard() async {
    final flashcardId = await studyQueueRepository.popStudyQueue();
    await studyQueueRepository.addFlashcardIdToReviewedQueue(flashcardId);
  }

  Future<void> loadQueueWithDeckId(DeckID deckId) async {
    final flashcards =
        await ref.read(flashcardsByDeckFutureProvider(deckId).future);
    final flashcardIds = flashcards.map((flashcard) => flashcard.id).toList();
    await studyQueueRepository.addFlashcardIdsToStudy(flashcardIds);
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

@riverpod
Stream<List<Flashcard>> flashcardsToStudyStream(
    FlashcardsToStudyStreamRef ref) {
  final studyFlashcardsService = ref.watch(studyFlashcardServiceProvider);
  return studyFlashcardsService.watchFlashcardsToStudy().map((value) {
    return value;
  });
}
