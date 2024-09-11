import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudySelectionContents extends ConsumerWidget {
  const StudySelectionContents({super.key, required this.studyState});

  final FlashcardStudyState studyState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: studyState.deckMap.length,
            itemBuilder: (context, index) {
              final deck = studyState.deckMap.keys.elementAt(index);
              final cardCount = studyState.deckMap[deck]!.length;
              return ListTile(
                title: Text(deck.title),
                subtitle: Text('$cardCount due cards'),
                onTap: () => ref
                    .read(flashcardStudyControllerProvider.notifier)
                    .selectDeck(deck),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => ref
                .read(flashcardStudyControllerProvider.notifier)
                .startStudyingAllDecks(),
            child: const Text('Study All Decks'),
          ),
        ),
      ],
    );
  }
}
