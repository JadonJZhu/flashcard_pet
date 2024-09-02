import 'package:flashcard_pet/src/common_widgets/alert_dialogs.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/deck_edit_form_fields.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/deck_editor_controller.dart';

class DeckEditScreen extends ConsumerWidget {
  final DeckID? deckId;

  const DeckEditScreen({super.key, this.deckId});

  void routeToDecksScreen(BuildContext context) {
    if (context.mounted) {
      context.goNamed(AppRoute.decks.name);
    }
  }

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
            child: DeckEditForm(
              deckId: deckId,
              exitScreen: () => routeToDecksScreen(context),
            ),
          ),
        ),
      ),
    );
  }
}

class DeckEditForm extends ConsumerStatefulWidget {
  final DeckID? deckId;
  final void Function()? exitScreen;

  const DeckEditForm({super.key, this.deckId, this.exitScreen});

  @override
  ConsumerState<DeckEditForm> createState() => _DeckEditFormState();
}

class _DeckEditFormState extends ConsumerState<DeckEditForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deckEditorControllerProvider(widget.deckId)).value!;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleField(
            initialValue: state.deck.title,
            onChanged: ref
                .read(deckEditorControllerProvider(widget.deckId).notifier)
                .updateDeckTitle,
          ),
          gapH24,
          Text('Flashcards', style: Theme.of(context).textTheme.titleLarge),
          gapH16,
          ...state.flashcards.asMap().entries.map(
            (entry) {
              final index = entry.key;
              final flashcard = entry.value;
              return FlashcardField(
                key: ValueKey(flashcard.id ?? index),
                initialFront: flashcard.front,
                initialBack: flashcard.back,
                onChangedFront: (value) => ref
                    .read(deckEditorControllerProvider(widget.deckId).notifier)
                    .updateFlashcard(index, front: value),
                onChangedBack: (value) => ref
                    .read(deckEditorControllerProvider(widget.deckId).notifier)
                    .updateFlashcard(index, back: value),
                onDelete: () => ref
                    .read(deckEditorControllerProvider(widget.deckId).notifier)
                    .deleteFlashcard(index),
                index: index + 1,
              );
            },
          ),
          gapH16,
          ElevatedButton(
            onPressed: ref
                .read(deckEditorControllerProvider(widget.deckId).notifier)
                .addFlashcard,
            child: const Text('Add Flashcard'),
          ),
          gapH24,
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                await ref
                    .read(deckEditorControllerProvider(widget.deckId).notifier)
                    .saveDeck();
                widget.exitScreen?.call();
              }
            },
            child: Text(widget.deckId == null ? 'Create Deck' : 'Update Deck'),
          ),
          if (widget.deckId != null) ...[
            const SizedBox(height: Sizes.p16),
            ElevatedButton(
              onPressed: () async {
                final confirmed = await showAlertDialog(
                  context: context,
                  title: "Are you sure you want to delete this deck?",
                  cancelActionText: "No",
                  defaultActionText: "Yes"
                );
                if (confirmed == true) {
                  await ref
                      .read(
                          deckEditorControllerProvider(widget.deckId).notifier)
                      .deleteDeck();
                  widget.exitScreen?.call();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Delete Deck'),
            ),
          ],
        ],
      ),
    );
  }
}
