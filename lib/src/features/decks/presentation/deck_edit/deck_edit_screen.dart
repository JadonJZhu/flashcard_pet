import 'package:flashcard_pet/src/common_widgets/alert_dialogs.dart';
import 'package:flashcard_pet/src/common_widgets/primary_button.dart';
import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/flashcard_state.dart';
import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/deck_edit_input_fields.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/deck_editor_controller.dart';

class DeckEditScreen extends StatelessWidget {
  final DeckID? deckId;

  const DeckEditScreen({super.key, this.deckId});

  void routeToDecksScreen(BuildContext context) {
    if (context.mounted) {
      context.goNamed(AppRoute.decks.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(deckId == null ? 'Create New Deck' : 'Edit Deck'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final flashcardsValue = deckId != null
              ? ref.watch(flashcardsByDeckFutureProvider(deckId!))
              : const AsyncData<List<Flashcard>>([]);
          final deckValue = deckId != null
              ? ref.watch(deckByIdFutureProvider(deckId!))
              : const AsyncData<Deck?>(null);

          return AsyncValueWidget(
            value: flashcardsValue,
            data: (flashcards) => AsyncValueWidget(
              value: deckValue,
              data: (deck) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(Sizes.p16),
                  child: Center(
                    child: DeckEditForm(
                      deck: deck,
                      flashcards: flashcards,
                      exitScreen: () => routeToDecksScreen(context),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DeckEditForm extends ConsumerStatefulWidget {
  const DeckEditForm({
    required this.flashcards,
    super.key,
    this.deck,
    this.exitScreen,
  });

  final Deck? deck;
  final List<Flashcard> flashcards;
  final void Function()? exitScreen;

  @override
  ConsumerState<DeckEditForm> createState() => _DeckEditFormState();
}

class _DeckEditFormState extends ConsumerState<DeckEditForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController titleController;
  late final List<FlashcardState> flashcardStates;
  final List<FlashcardID> deletedCardsIds = [];

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: widget.deck?.title);

    if (widget.flashcards.isEmpty) {
      flashcardStates = [FlashcardState.empty()];
    } else {
      flashcardStates = widget.flashcards
          .map((flashcard) => FlashcardState.fromFlashcard(flashcard))
          .toList();
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    for (final flashcardState in flashcardStates) {
      flashcardState.frontController.dispose();
      flashcardState.backController.dispose();
    }
    super.dispose();
  }

  bool _validateFlashcardsNotEmpty(List<FlashcardState> flashcardStates) {
    for (final flashcardState in flashcardStates) {
      if (flashcardState.frontController.document.isEmpty() ||
          flashcardState.backController.document.isEmpty()) {
        return false;
      }
    }
    return true;
  }

  void onDeleteCard(int index, FlashcardState flashcardState) {
    if (flashcardState.originalFlashcard != null) {
      deletedCardsIds.add(flashcardState.originalFlashcard!.id);
    }
    flashcardState.frontController.dispose();
    flashcardState.backController.dispose();

    setState(
      () => flashcardStates.removeAt(index),
    );
  }

  Future<void> _saveDeck() async {
    final deck = widget.deck ??
        Deck(
          id: const Uuid().v4(),
          title: titleController.text,
        );

    final flashcards = flashcardStates.where((flashcardState) {
      return flashcardState.isModified;
    }).map((flashcardState) {
      return Flashcard(
        id: flashcardState.originalFlashcard?.id ?? const Uuid().v4(),
        deckId: deck.id,
        frontContent: flashcardState.frontController.document,
        backContent: flashcardState.backController.document,
        nextDueDate: flashcardState.originalFlashcard?.nextDueDate ?? DateTime.now(),
      );
    }).toList();

    await ref.read(deckEditorControllerProvider.notifier).saveDeck(
        deck: deck,
        cardsToUpdate: flashcards,
        deletedCardsIds: deletedCardsIds);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(deckEditorControllerProvider);

    return AsyncValueWidget(
      value: state,
      data: (_) => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleField(controller: titleController),
            gapH24,
            Text('Flashcards', style: Theme.of(context).textTheme.titleLarge),
            gapH16,
            ...flashcardStates.asMap().entries.map(
              (entry) {
                final index = entry.key;
                final flashcardState = entry.value;
                return FlashcardField(
                  index: index,
                  flashcardState: flashcardState,
                  onDelete: () {
                    onDeleteCard(index, flashcardState);
                  },
                );
              },
            ),
            gapH16,
            ElevatedButton(
              onPressed: () => setState(
                () => flashcardStates.add(FlashcardState.empty()),
              ),
              child: const Text('Add Flashcard'),
            ),
            gapH24,
            PrimaryButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  if (_validateFlashcardsNotEmpty(flashcardStates) == false) {
                    await showAlertDialog(
                      context: context,
                      title: "Please make sure no flashcard fields are empty.",
                    );
                    return;
                  }

                  await _saveDeck();

                  widget.exitScreen?.call();
                }
              },
              text: widget.deck == null ? 'Create Deck' : 'Update Deck',
            ),
            if (widget.deck != null) ...[
              const SizedBox(height: Sizes.p16),
              PrimaryButton(
                onPressed: () async {
                  final confirmed = await showAlertDialog(
                      context: context,
                      title: "Are you sure you want to delete this deck?",
                      cancelActionText: "No",
                      defaultActionText: "Yes");
                  if (confirmed == true) {
                    await ref
                        .read(deckEditorControllerProvider.notifier)
                        .deleteDeck(widget.deck!.id);
                    widget.exitScreen?.call();
                  }
                },
                text: 'Delete Deck',
              ),
            ],
          ],
        ),
      ),
    );
  }
}
