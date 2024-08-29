import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/study_flashcard_controller.dart';
import 'package:flashcard_pet/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudyFlashcardScreen extends StatelessWidget {
  const StudyFlashcardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Study Flashcard Screen"),
      ),
      body: const StudyFlashcardScreenContents(),
    );
  }
}

class StudyFlashcardScreenContents extends ConsumerWidget {
  const StudyFlashcardScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    ref.listen(
      studyFlashcardControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );

    final studyStateValue = ref.watch(studyFlashcardControllerProvider);

    return AsyncValueWidget(
      value: studyStateValue,
      data: (studyState) {
        final flashcard = studyState.currentCard;
        if (flashcard != null) {
          final isFlipped = studyState.isFlipped;
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        isFlipped ? flashcard.back : flashcard.front,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
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
                    ElevatedButton(
                      onPressed: () => ref
                          .read(studyFlashcardControllerProvider.notifier)
                          .flipCard(),
                      child: Text(isFlipped ? 'Flip' : 'Flip'),
                    ),
                    if (isFlipped)
                      ElevatedButton(
                        onPressed: () => ref
                            .read(studyFlashcardControllerProvider.notifier)
                            .loadNextCard(),
                        child: const Text("Next"),
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
