import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/delay.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';

class FakeStudyQueueRepository implements StudyQueueRepository {
  FakeStudyQueueRepository({this.addDelay = true});

  final bool addDelay;

  final _studyQueues = InMemoryStore<Map<QueueType, List<FlashcardID>>>({
    QueueType.reviewed: [],
    QueueType.toStudy:
        kFlashcards.values.map((flashcard) => flashcard.id).toList(),
  });

  @override
  Stream<List<FlashcardID>> watchFlashcardsIdsToStudy() {
    return _studyQueues.stream.map(
      (studyQueues) => studyQueues[QueueType.toStudy]!,
    );
  }

  @override
  Stream<List<FlashcardID>> watchReviewedQueue() {
    return _studyQueues.stream
        .map((studyQueues) => studyQueues[QueueType.reviewed]!);
  }

  @override
  Future<FlashcardID> popStudyQueue() async {
    await delay(addDelay);
    final studyQueue = _studyQueues.value[QueueType.toStudy]!;
    final flashcardId = studyQueue.removeAt(0);
    _studyQueues.value[QueueType.toStudy] = studyQueue;
    return flashcardId;
  }

  @override
  Future<void> addFlashcardIdToStudy(FlashcardID flashcardId) async {
    await delay(addDelay);
    _studyQueues.value[QueueType.toStudy]!.add(flashcardId);
  }

  @override
  Future<void> addFlashcardIdToReviewedQueue(FlashcardID flashcardId) async {
    await delay(addDelay);
    _studyQueues.value[QueueType.reviewed]!.add(flashcardId);
  }

  @override
  Future<List<FlashcardID>> fetchFlashcardsIdsToStudy() async {
    await delay(addDelay);
    return _studyQueues.value[QueueType.toStudy] ?? <FlashcardID>[];
  }
}
