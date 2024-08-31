import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/decks/presentation/edit_deck/deck_edit_form_fields.dart';
import 'package:flashcard_pet/src/features/decks/presentation/edit_deck/deck_editor_controller.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';

class DeckEditScreen extends ConsumerWidget {
  final DeckID? deckId;

  const DeckEditScreen({super.key, this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(deckEditorControllerProvider(deckId));

    return Scaffold(
      appBar: AppBar(
        title: Text(deckId == null ? 'Create New Deck' : 'Edit Deck'),
      ),
      body: AsyncValueWidget(
        value: state,
        data: (_) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: DeckEditForm(deckId: deckId),
          ),
        ),
      ),
    );
  }
}

class DeckEditForm extends ConsumerStatefulWidget {
  final DeckID? deckId;

  const DeckEditForm({super.key, this.deckId});

  @override
  ConsumerState<DeckEditForm> createState() => _DeckEditFormState();
}

class _DeckEditFormState extends ConsumerState<DeckEditForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller =
        ref.watch(deckEditorControllerProvider(widget.deckId).notifier);
    final state = ref.watch(deckEditorControllerProvider(widget.deckId)).value!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleField(
            initialValue: state.deck.title,
            onChanged: controller.updateDeckTitle,
          ),
          gapH24,
          Text('Flashcards', style: Theme.of(context).textTheme.titleLarge),
          gapH16,
          ...state.flashcards.asMap().entries.map((entry) {
            final index = entry.key;
            final flashcard = entry.value;
            return FlashcardField(
              key: ValueKey(flashcard.id ?? index),
              initialFront: flashcard.front,
              initialBack: flashcard.back,
              onChangedFront: (value) =>
                  controller.updateFlashcard(index, front: value),
              onChangedBack: (value) =>
                  controller.updateFlashcard(index, back: value),
            );
          }),
          gapH16,
          ElevatedButton(
            onPressed: controller.addFlashcard,
            child: const Text('Add Flashcard'),
          ),
          gapH24,
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await controller.saveDeck();
                if (context.mounted) {
                  context.goNamed(AppRoute.decks.name);
                }
              }
            },
            child: Text(widget.deckId == null ? 'Create Deck' : 'Update Deck'),
          ),
        ],
      ),
    );
  }
}

