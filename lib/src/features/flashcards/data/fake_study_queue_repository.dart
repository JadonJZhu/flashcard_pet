import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/delay.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';
import 'package:flutter/foundation.dart';

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
    final studyQueue = _studyQueues.value;
    final flashcardId = studyQueue[QueueType.toStudy]!.removeAt(0);
    _studyQueues.value = studyQueue;
    debugPrint('popped study queue');
    return flashcardId;
  }

  @override
  Future<void> addFlashcardIdsToStudy(List<FlashcardID> flashcardIds) async {
    await delay(addDelay);
    _studyQueues.value[QueueType.toStudy]!.addAll(flashcardIds);
  }

  @override
  Future<void> addFlashcardIdToReviewedQueue(FlashcardID flashcardId) async {
    await delay(addDelay);
    _studyQueues.value[QueueType.reviewed]!.add(flashcardId);
    debugPrint("added flashcard to review queue");
  }

  @override
  Future<List<FlashcardID>> fetchFlashcardsIdsToStudy() async {
    await delay(addDelay);
    return _studyQueues.value[QueueType.toStudy] ?? <FlashcardID>[];
  }
}
