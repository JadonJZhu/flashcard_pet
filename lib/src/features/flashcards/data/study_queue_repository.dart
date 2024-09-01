import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_queue_repository.g.dart';

enum QueueType {
  toStudy,
  reviewed,
}

abstract class StudyQueueRepository {
  Stream<List<FlashcardID>> watchFlashcardsIdsToStudy();
  Future<List<FlashcardID>> fetchFlashcardsIdsToStudy();
  Future<void> addFlashcardIdsToStudy(List<FlashcardID> flashcardIds);
  Future<FlashcardID> popStudyQueue();
  Future<void> deleteFlashcardsById(List<FlashcardID> ids);

  Stream<List<FlashcardID>> watchReviewedQueue();
  Future<void> addFlashcardIdToReviewedQueue(FlashcardID flashcardId);
}

@Riverpod(keepAlive: true)
StudyQueueRepository studyQueueRepository(StudyQueueRepositoryRef ref) {
  throw UnimplementedError();
}

@riverpod
Stream<List<FlashcardID>> flashcardIdsToStudyStream(
    FlashcardIdsToStudyStreamRef ref) {
  final studyQueueRepository = ref.watch(studyQueueRepositoryProvider);
  return studyQueueRepository.watchFlashcardsIdsToStudy();
}

@riverpod
Future<List<FlashcardID>> flashcardIdsToStudyFuture(
    FlashcardIdsToStudyFutureRef ref) {
  final studyQueueRepository = ref.watch(studyQueueRepositoryProvider);
  return studyQueueRepository.fetchFlashcardsIdsToStudy();
}

@riverpod
Future<FlashcardID?> flashcardIdToStudyFuture(
    FlashcardIdToStudyFutureRef ref) async {
  final flashcardsToStudy =
      await ref.watch(flashcardIdsToStudyFutureProvider.future);
  return flashcardsToStudy.firstOrNull;
}

@riverpod
Stream<FlashcardID?> flashcardIdToStudyStream(FlashcardIdToStudyStreamRef ref) {
  final studyQueueRepository = ref.watch(studyQueueRepositoryProvider);
  return studyQueueRepository
      .watchFlashcardsIdsToStudy()
      .map((flashcardIds) => flashcardIds.firstOrNull);
}

@riverpod
Stream<List<FlashcardID>> reviewedFlashcardsIdsStream(
    ReviewedFlashcardsIdsStreamRef ref) {
  final studyQueueRepository = ref.watch(studyQueueRepositoryProvider);
  return studyQueueRepository.watchReviewedQueue();
}

@riverpod
Future<FlashcardID?> lastReviewedFlashcardIdFuture(
    LastReviewedFlashcardIdFutureRef ref) async {
  final reviewedFlashcards =
      await ref.watch(reviewedFlashcardsIdsStreamProvider.future);
  return reviewedFlashcards.last;
}

@riverpod
Future<int> studyQueueCountFuture(StudyQueueCountFutureRef ref) async {
  final studyQueue = await ref.watch(flashcardIdsToStudyFutureProvider.future);
  return studyQueue.length;
}
