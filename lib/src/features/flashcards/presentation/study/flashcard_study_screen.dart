import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_contents.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/flashcard_study_controller.dart';
import 'package:flashcard_pet/src/features/flashcards/presentation/study/study_selection_contents.dart';
import 'package:flashcard_pet/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        debugPrint(
            "rebuilt contents:\nstudyState's card: ${studyState.currentCard}");
        if (studyState.currentCard == null) {
          return StudySelectionContents(studyState: studyState);
        } else {
          debugPrint("Flashcard study card");
          return FlashcardStudyContents(studyState: studyState);
        }
      },
    );
  }
}




