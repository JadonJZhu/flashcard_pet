import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/features/study/presentation/flashcard_study_screen.dart';
import 'package:flashcard_pet/src/features/study/presentation/study_options_widget.dart';
import 'package:flashcard_pet/src/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const HomeScreenContents(),
    );
  }
}

class HomeScreenContents extends ConsumerWidget {
  const HomeScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Column(
      children: [
        // TODO - Game Widget
        StudyOptionsWidget(),
      ],
    );
  }
}
