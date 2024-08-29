import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/delay.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';
import 'package:flutter/foundation.dart';

class FakeStudyQueueRepository implements StudyQueueRepository {
  FakeStudyQueueRepository({this.addDelay = true});

  final bool addDelay;

  final _studyQueue = InMemoryStore<List<FlashcardID>>(
    kFlashcards.values.map((flashcard) => flashcard.id).toList(),
  );

  final _reviewQueue = InMemoryStore<List<FlashcardID>>([]);

  @override
  Stream<List<FlashcardID>> watchFlashcardsIdsToStudy() {
    return _studyQueue.stream;
  }

  @override
  Stream<List<FlashcardID>> watchReviewedQueue() {
    return _reviewQueue.stream;
  }

  @override
  Future<FlashcardID> popStudyQueue() async {
    debugPrint('popped study queue');
    await delay(addDelay);
    final studyQueue = _studyQueue.value;
    final flashcardId = studyQueue.removeAt(0);
    _studyQueue.update(studyQueue);
    return flashcardId;
  }

  @override
  Future<void> addFlashcardIdsToStudy(List<FlashcardID> flashcardIds) async {
    await delay(addDelay);
    final studyQueue = _studyQueue.value..addAll(flashcardIds);
    _studyQueue.update(studyQueue);
  }

  @override
  Future<void> addFlashcardIdToReviewedQueue(FlashcardID flashcardId) async {
    await delay(addDelay);
    final reviewQueue = _reviewQueue.value;
    reviewQueue.add(flashcardId);
    _reviewQueue.update(reviewQueue);
    debugPrint("added flashcard to review queue");
  }

  @override
  Future<List<FlashcardID>> fetchFlashcardsIdsToStudy() async {
    await delay(addDelay);
    return _studyQueue.value;
  }
}
