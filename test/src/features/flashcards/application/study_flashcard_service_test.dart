import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late MockFlashcardsRepository flashcardsRepository;
  late MockStudyQueueRepository studyQueueRepository;

  setUp(() {
    flashcardsRepository = MockFlashcardsRepository();
    studyQueueRepository = MockStudyQueueRepository();
  });

  StudyFlashcardService makeStudyFlashcardService() {
    final container = ProviderContainer(
      overrides: [
        flashcardsRepositoryProvider.overrideWithValue(flashcardsRepository),
        studyQueueRepositoryProvider.overrideWithValue(studyQueueRepository),
      ],
    );
    addTearDown(container.dispose);
    return container.read(studyFlashcardServiceProvider);
  }

  group('deleteFlashcardsById', () {
    test('using multiple valid ids', () async {
      // set up
      const ids = <FlashcardID>['1', '2'];
      when(() => studyQueueRepository.deleteFlashcardsById(ids)).thenAnswer(
        (_) => Future.value(),
      );
      when(() => flashcardsRepository.deleteFlashcardsById(ids)).thenAnswer(
        (_) => Future.value(),
      );
      final studyFlashcardService = makeStudyFlashcardService();
      // run
      await studyFlashcardService.deleteFlashcardsById(ids);
      // verify
      verify(
        () => studyQueueRepository.deleteFlashcardsById(ids),
      ).called(1);
      verify(
        () => flashcardsRepository.deleteFlashcardsById(ids),
      ).called(1);
    });
  });
}
