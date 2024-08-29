import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:flashcard_pet/src/utils/notifier_mounted.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'decks_list_screen_controller.g.dart';

@riverpod
class DecksListScreenController extends _$DecksListScreenController
    with NotifierMounted {
  @override
  Future<List<Deck>> build() async {
    ref.onDispose(setUnmounted);

    final decks = await ref.watch(decksListStreamProvider.future);
    return decks;
  }

  Future<bool> loadQueueWithDeckId(DeckID deckId) async {
    final decks = state.valueOrNull;

    state = const AsyncLoading<List<Deck>>();

    final studyService = ref.read(studyFlashcardServiceProvider);
    final loadState =
        await AsyncValue.guard(() => studyService.loadQueueWithDeckId(deckId));

    if (loadState.hasError) {
      if (mounted) {
        state = AsyncError(loadState.error!, loadState.stackTrace!);
      }
      return false;
    } else {
      if (mounted) {
        state = AsyncData(decks ?? []);
      }
      return true;
    }
  }
}
