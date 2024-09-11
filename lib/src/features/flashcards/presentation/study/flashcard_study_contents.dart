import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_controller.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/quill_content_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AnswerChoice {
  easy,
  difficult,
  forgot;
}

class FlashcardStudyContents extends ConsumerWidget {
  const FlashcardStudyContents({super.key, required this.studyState});

  final FlashcardStudyState studyState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flashcard = studyState.currentCard!;
    final isFlipped = studyState.isFlipped;
    final cardContent =
        isFlipped ? flashcard.backContent : flashcard.frontContent;

    return Column(
      children: [
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: IntrinsicWidth(
                    child: QuillContentDisplay(document: cardContent),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text("Cards left: ${studyState.remainingCount}"),
              const SizedBox(height: 16),
              if (!isFlipped)
                ElevatedButton(
                  onPressed: () => ref
                      .read(flashcardStudyControllerProvider.notifier)
                      .flipCard(),
                  child: const Text('Flip'),
                )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: AnswerChoice.values
                      .map((choice) => ElevatedButton(
                            onPressed: () => ref
                                .read(flashcardStudyControllerProvider.notifier)
                                .answer(flashcard, choice),
                            child: Text(choice.name),
                          ))
                      .toList(),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
