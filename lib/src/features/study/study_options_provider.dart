import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/study/data/flashcards_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';

part 'study_options_provider.g.dart';

@riverpod
Stream<List<StudyOption>> studyOptionsStream(StudyOptionsStreamRef ref) async* {
  final allCardsDue = await ref.watch(dueFlashcardsStreamProvider.future);
  final studyOptions = <StudyOption>[];

  for (final card in allCardsDue) {
    final optionIndex =
        studyOptions.indexWhere((option) => option.deck.id == card.deckId);
    if (optionIndex == -1) {
      final deck = await ref.watch(deckByIdStreamProvider(card.deckId).future);
      if (deck == null) {
        throw StateError("deck id: ${card.deckId} not found");
      }
      studyOptions.add(StudyOption(deck: deck, flashcardIds: [card.id]));
    } else {
      studyOptions[optionIndex].flashcardIds.add(card.id);
    }
  }

  yield studyOptions;
}



class StudyOption {
  StudyOption({
    required this.deck,
    required this.flashcardIds,
  });

  final Deck deck;
  final List<FlashcardID> flashcardIds;
}

extension StudyOptionX on StudyOption {
  int get cardsCount => flashcardIds.length;
}


