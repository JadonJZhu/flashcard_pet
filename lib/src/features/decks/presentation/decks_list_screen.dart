import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/features/decks/presentation/decks_list_screen_controller.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_tile.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DeckListScreen extends StatelessWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Deck List Screen"),
        actions: [
          IconButton(
            onPressed: () => context.goNamed(AppRoute.edit.name),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const DeckListScreenContents(),
    );
  }
}

class DeckListScreenContents extends ConsumerWidget {
  const DeckListScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksListValue = ref.watch(decksListScreenControllerProvider);

    return AsyncValueWidget(
      value: decksListValue,
      data: (decksList) {
        return ListView.builder(
            itemCount: decksList.length,
            itemBuilder: (tileContext, index) {
              final deck = decksList[index];
              return DeckTile(
                deck: deck,
                onPressed: () async {
                  final success = await ref
                      .read(decksListScreenControllerProvider.notifier)
                      .loadQueueWithDeckId(deck.id);
                  if (success && context.mounted) {
                    context.goNamed(AppRoute.study.name);
                  }
                },
              );
            });
      },
    );
  }
}
