import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'decks_list_screen_controller.g.dart';

@riverpod
class DecksListScreenController extends _$DecksListScreenController {
  @override
  Future<List<Deck>> build() async {
    final decks = await ref.watch(decksListStreamProvider.future);
    return decks;
  }

  Future<bool> loadQueueWithDeckId(DeckID deckId) async {
    state = const AsyncLoading<List<Deck>>().copyWithPrevious(state);

    final studyService = ref.read(studyFlashcardServiceProvider);
    final loadState =
        await AsyncValue.guard(() => studyService.loadQueueWithDeckId(deckId));

    if (loadState.hasError) {
      state = AsyncError(loadState.error!, loadState.stackTrace!);
      return false;
    } else {
      state = AsyncData(state.value!);
      return true;
    }
  }
}
