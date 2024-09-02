import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';

part 'deck_editor_controller.g.dart';

@riverpod
class DeckEditorController extends _$DeckEditorController {
  @override
  FutureOr<DeckEditorState> build(DeckID? deckId) async {
    if (deckId == null) {
      return DeckEditorState(
        deck: Deck(id: const Uuid().v4(), title: ''),
        flashcards: [FlashcardState.empty()],
      );
    }

    final deck = await ref.read(decksRepositoryProvider).fetchDeckById(deckId);

    if (deck == null) {
      return DeckEditorState(
        deck: Deck(id: const Uuid().v4(), title: ''),
        flashcards: [FlashcardState.empty()],
      );
    }

    final flashcards = await ref
        .read(flashcardsRepositoryProvider)
        .fetchFlashcardsByDeck(deckId);

    return DeckEditorState(
      deck: deck,
      flashcards:
          flashcards.map((f) => FlashcardState.fromFlashcard(f)).toList(),
    );
  }

  void updateDeckTitle(String title) {
    state = AsyncData(state.value!.copyWith(
      deck: state.value!.deck.copyWith(title: title),
    ));
  }

  void addFlashcard() {
    state = AsyncData(state.value!.copyWith(
      flashcards: [...state.value!.flashcards, FlashcardState.empty()],
    ));
  }

  void updateFlashcard(int index,
      {quill.Document? front, quill.Document? back}) {
    final updatedFlashcards = List<FlashcardState>.of(state.value!.flashcards);
    updatedFlashcards[index] = updatedFlashcards[index].copyWith(
      front: front ?? updatedFlashcards[index].front,
      back: back ?? updatedFlashcards[index].back,
      isModified: true,
    );
    state = AsyncData(state.value!.copyWith(flashcards: updatedFlashcards));
  }

  void deleteFlashcard(int index) {
    final updatedFlashcards = List<FlashcardState>.of(state.value!.flashcards);
    final deletedFlashcard = updatedFlashcards.removeAt(index);
    if (deletedFlashcard.id != null) {
      state = AsyncData(state.value!.copyWith(
        flashcards: updatedFlashcards,
        deletedFlashcardIds: [
          ...state.value!.deletedFlashcardIds,
          deletedFlashcard.id!
        ],
      ));
    } else {
      state = AsyncData(state.value!.copyWith(flashcards: updatedFlashcards));
    }
  }

  Future<void> saveDeck() async {
    final currentState = state;
    final currentValue = state.value!;

    state = const AsyncLoading();

    try {
      // Save or update the deck
      await ref.read(decksRepositoryProvider).setDeck(currentValue.deck);

      // Update flashcards
      final flashcardsToUpdate = currentValue.flashcards
          .where((fs) => fs.isModified)
          .map((fs) => Flashcard(
                id: fs.id ?? const Uuid().v4(),
                deckId: currentValue.deck.id,
                frontContent: fs.front,
                backContent: fs.back,
              ))
          .toList();

      await ref
          .read(flashcardsRepositoryProvider)
          .setFlashcards(flashcardsToUpdate);

      await ref
          .read(studyFlashcardServiceProvider)
          .deleteFlashcardsById(currentValue.deletedFlashcardIds);

      state = currentState;
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteDeck() async {
    final currentValue = state.value!;

    state = const AsyncLoading();

    try {
      await ref
          .read(studyFlashcardServiceProvider)
          .deleteFlashcardsByDeckId(currentValue.deck.id);

      await ref
          .read(decksRepositoryProvider)
          .deleteDeckById(currentValue.deck.id);

      state = AsyncData(
        DeckEditorState(
          deck: Deck(id: const Uuid().v4(), title: ''),
          flashcards: [FlashcardState.empty()],
        ),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

class DeckEditorState {
  DeckEditorState({
    required this.deck,
    required this.flashcards,
    this.deletedFlashcardIds = const [],
  });

  final Deck deck;
  final List<FlashcardState> flashcards;
  final List<FlashcardID> deletedFlashcardIds;

  DeckEditorState copyWith({
    Deck? deck,
    List<FlashcardState>? flashcards,
    List<FlashcardID>? deletedFlashcardIds,
  }) {
    return DeckEditorState(
      deck: deck ?? this.deck,
      flashcards: flashcards ?? this.flashcards,
      deletedFlashcardIds: deletedFlashcardIds ?? this.deletedFlashcardIds,
    );
  }
}

class FlashcardState {
  FlashcardState({
    this.id,
    required this.front,
    required this.back,
    required this.isModified,
  });

  final String? id;
  final quill.Document front;
  final quill.Document back;
  final bool isModified;

  factory FlashcardState.empty() => FlashcardState(
        front: quill.Document(),
        back: quill.Document(),
        isModified: true,
      );

  factory FlashcardState.fromFlashcard(Flashcard flashcard) => FlashcardState(
        id: flashcard.id,
        front: flashcard.frontContent,
        back: flashcard.backContent,
        isModified: false,
      );

  FlashcardState copyWith({
    String? id,
    quill.Document? front,
    quill.Document? back,
    bool? isModified,
  }) {
    return FlashcardState(
      id: id ?? this.id,
      front: front ?? this.front,
      back: back ?? this.back,
      isModified: isModified ?? this.isModified,
    );
  }
}
