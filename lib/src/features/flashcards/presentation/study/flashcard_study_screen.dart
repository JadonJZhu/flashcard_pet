import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/quill_content_display.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_controller.dart';
import 'package:flashcard_pet/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AnswerChoice {
  easy,
  difficult,
  forgot;
}

class FlashcardStudyScreen extends StatelessWidget {
  const FlashcardStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Flashcard Screen"),
      ),
      body: const FlashcardStudyScreenContents(),
    );
  }
}

class FlashcardStudyScreenContents extends ConsumerWidget {
  const FlashcardStudyScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      flashcardStudyControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final studyStateValue = ref.watch(flashcardStudyControllerProvider);

    return AsyncValueWidget(
      value: studyStateValue,
      data: (studyState) {
        final flashcard = studyState.currentCard;
        if (flashcard != null) {
          final isFlipped = studyState.isFlipped;
          final cardContent =
              isFlipped ? flashcard.backContent : flashcard.frontContent;

          return Column(
            children: [
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 800,
                    ),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Cards left: ${studyState.remainingCount}"),
                    if (!isFlipped)
                      ElevatedButton(
                        onPressed: () => ref
                            .read(flashcardStudyControllerProvider.notifier)
                            .flipCard(),
                        child: Text(isFlipped ? 'Flip' : 'Flip'),
                      ),
                    if (isFlipped)
                      for (final choice in AnswerChoice.values)
                        ElevatedButton(
                          onPressed: () => ref
                              .read(flashcardStudyControllerProvider.notifier)
                              .answer(flashcard, choice),
                          child: Text(choice.name),
                        ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const EmptyPlaceholderWidget(
            message: "Finished all cards!",
          );
        }
      },
    );
  }
}
