import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/utils/fake_async_util.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';

class FakeStudyQueueRepository implements StudyQueueRepository {
  FakeStudyQueueRepository({this.addDelay = true});

  final bool addDelay;

  final _studyQueue = InMemoryStore<List<FlashcardID>>(
    kDummyFlashcardsMap.values.map((flashcard) => flashcard.id).toList(),
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
    await delay(addDelay);
    final studyQueue = _studyQueue.value;
    final flashcardId = studyQueue.removeAt(0);
    _studyQueue.update(studyQueue);
    return flashcardId;
  }

  @override
  Future<void> deleteFlashcardsById(List<FlashcardID> ids) async {
    await delay(addDelay);
    final studyQueue = _studyQueue.value;
    for (final id in ids) {
      studyQueue.remove(id);
    }
    _studyQueue.update(studyQueue);
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
  }

  @override
  Future<List<FlashcardID>> fetchFlashcardsIdsToStudy() async {
    await delay(addDelay);
    return _studyQueue.value;
  }
}
