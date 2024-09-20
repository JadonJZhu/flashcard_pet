import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/features/study/study_options_provider.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyOptionsWidget extends ConsumerWidget {
  const StudyOptionsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studyOptionsAsyncValue = ref.watch(studyOptionsStreamProvider);

    return AsyncValueWidget(
      value: studyOptionsAsyncValue,
      data: (studyOptions) => Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: studyOptions.length,
              itemBuilder: (context, index) {
                final option = studyOptions[index];
                final deck = option.deck;
                final cardCount = option.cardsCount;
                return ListTile(
                  title: Text(deck.title),
                  subtitle: Text('$cardCount due cards'),
                  onTap: () => context.goNamed(), // TODO - flashcard study screen
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
              child: const Text('Study All Cards'),
            ),
          ),
        ],
      ),
    );
  }
}
