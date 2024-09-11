import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/mutable_flashcard.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_contents.dart';
import 'package:flashcard_pet/src/utils/null_wrapper.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flashcard_study_controller.g.dart';

@riverpod
class FlashcardStudyController extends _$FlashcardStudyController {
  @override
  Future<FlashcardStudyState> build() async {
    final dueFlashcards = await ref.read(dueFlashcardsStreamProvider.future);
    final deckMap = await _groupFlashcardsByDeck(dueFlashcards);

    return FlashcardStudyState(
      deckMap: deckMap,
      selectedDeck: null,
      currentCard: null,
      remainingCount: dueFlashcards.length,
      isFlipped: false,
    );
  }

  Future<Map<Deck, List<Flashcard>>> _groupFlashcardsByDeck(
      List<Flashcard> flashcards) async {
    final deckMap = <Deck, List<Flashcard>>{};
    for (final card in flashcards) {
      final deck = await ref.read(deckByIdFutureProvider(card.deckId).future);
      if (deck == null) {
        throw Exception("Deck with id ${card.deckId} not found.");
      }
      deckMap.putIfAbsent(deck, () => []).add(card);
    }
    return deckMap;
  }

  void selectDeck(Deck? deck) {
    state = AsyncData(state.value!.copyWith(
      selectedDeck: deck,
      currentCard:
          Wrapped(deck != null ? state.value!.deckMap[deck]!.first : null),
      remainingCount: deck != null
          ? state.value!.deckMap[deck]!.length
          : state.value!.remainingCount,
    ));
  }

  void startStudyingAllDecks() {
    final allCards =
        state.value!.deckMap.values.expand((cards) => cards).toList();
    state = AsyncData(state.value!.copyWith(
      selectedDeck: null,
      currentCard: Wrapped(allCards.first),
      remainingCount: allCards.length,
    ));
  }

  void flipCard() {
    state = AsyncValue.data(
        state.value!.copyWith(isFlipped: !state.value!.isFlipped));
  }

  Future<void> _updateCard(Flashcard card) async {
    state = const AsyncLoading();
    final successState = await AsyncValue.guard(
        () => ref.read(flashcardsRepositoryProvider).setFlashcard(card));
    if (successState.hasError) {
      state = AsyncError(successState.error!, successState.stackTrace!);
      return;
    }
  }

  Future<void> answer(Flashcard card, AnswerChoice answerChoice) async {
    final updatedCard = card.setNextReview(answerChoice);

    await _updateCard(updatedCard);

    final currentState = state.value!;
    final updatedDeckMap =
        Map<Deck, List<Flashcard>>.from(currentState.deckMap);
    final deck = currentState.deckMap.entries
        .firstWhere((entry) => entry.key.id == card.deckId)
        .key;

    updatedDeckMap[deck] =
        updatedDeckMap[deck]!.where((c) => c.id != card.id).toList();

    final nextCard = _getNextCard(updatedDeckMap, currentState.selectedDeck);
    if (nextCard == null) {
      updatedDeckMap.remove(deck);
    }

    state = AsyncData(currentState.copyWith(
      deckMap: updatedDeckMap,
      currentCard: Wrapped(nextCard),
      remainingCount: currentState.remainingCount - 1,
      isFlipped: false,
    ));
  }

  Flashcard? _getNextCard(
      Map<Deck, List<Flashcard>> deckMap, Deck? selectedDeck) {
    if (selectedDeck != null) {
      return deckMap[selectedDeck]!.firstOrNull;
    } else {
      final allCards = deckMap.values.expand((cards) => cards).toList();
      return allCards.firstOrNull;
    }
  }
}

class FlashcardStudyState {
  FlashcardStudyState({
    required this.deckMap,
    required this.selectedDeck,
    required this.currentCard,
    required this.remainingCount,
    required this.isFlipped,
  });

  final Map<Deck, List<Flashcard>> deckMap;
  final Deck? selectedDeck;
  final Flashcard? currentCard;
  final int remainingCount;
  final bool isFlipped;

  FlashcardStudyState copyWith({
    Map<Deck, List<Flashcard>>? deckMap,
    Deck? selectedDeck,
    Wrapped<Flashcard?>? currentCard,
    int? remainingCount,
    bool? isFlipped,
  }) {
    return FlashcardStudyState(
      deckMap: deckMap ?? this.deckMap,
      selectedDeck: selectedDeck ?? this.selectedDeck,
      currentCard: currentCard != null ? currentCard.value : this.currentCard,
      remainingCount: remainingCount ?? this.remainingCount,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}
