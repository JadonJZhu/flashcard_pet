import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/data/study_queue_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockFlashcardsRepository extends Mock implements FlashcardsRepository {}

class MockStudyQueueRepository extends Mock implements StudyQueueRepository {}
