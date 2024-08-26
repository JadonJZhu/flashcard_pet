import 'package:flashcard_pet/src/common_widgets/async_value_widget.dart';
import 'package:flashcard_pet/src/features/decks/data/fake_deck_repository.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeckListScreen extends StatelessWidget {
  const DeckListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Deck List Screen"),
        ),
        body: const DeckListScreenContents());
  }
}

class DeckListScreenContents extends ConsumerWidget {
  const DeckListScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decksListValue = ref.watch(decksListStreamProvider);
    return AsyncValueWidget(
      value: decksListValue,
      data: (decksList) {
        return ListView.builder(
          itemCount: decksList.length,
          itemBuilder: (context, index) => DeckTile(
            deck: decksList[index],
          ),
        );
      },
    );
  }
}
