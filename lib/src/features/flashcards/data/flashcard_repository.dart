import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashcard_repository.g.dart';

// TODO: Implement with Firebase

abstract class FlashcardsRepository {
  Stream<List<Flashcard>> watchFlashcards();
  Stream<Flashcard?> watchFlashcardById(FlashcardID flashcardId);
  Future<Flashcard?> fetchFlashcardById(FlashcardID flashcardId);
}

@Riverpod(keepAlive: true)
FlashcardsRepository flashcardsRepository(FlashcardsRepositoryRef ref) {
  // TODO: create and return repository
  throw UnimplementedError();
}

@riverpod
Stream<List<Flashcard>> flashcardsStream(FlashcardsStreamRef ref) {
  final flashcardsRepository = ref.watch(flashcardsRepositoryProvider);
  return flashcardsRepository.watchFlashcards();
}

@riverpod
Future<List<Flashcard>> flashcardsByDeckFuture(
    FlashcardsByDeckFutureRef ref, DeckID deckId) async {
  final flashcards = await ref.watch(flashcardsStreamProvider.future);
  return flashcards.where((flashcard) => flashcard.deckId == deckId).toList();
}

@riverpod
Stream<Flashcard?> flashcardByIdStream(FlashcardByIdStreamRef ref, FlashcardID flashcardId) {
  final flashcardsRepository = ref.watch(flashcardsRepositoryProvider);
  return flashcardsRepository.watchFlashcardById(flashcardId);
}

@riverpod
Future<Flashcard?> flashcardByIdFuture(
    FlashcardByIdFutureRef ref, FlashcardID flashcardId) {
  final flashcardsRepository = ref.watch(flashcardsRepositoryProvider);
  return flashcardsRepository.fetchFlashcardById(flashcardId);
}





