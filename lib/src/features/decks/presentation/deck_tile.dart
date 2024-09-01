import 'package:flashcard_pet/src/common_widgets/empty_placeholder_widget.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeckTile extends StatelessWidget {
  const DeckTile({super.key, required this.deck, required this.onPressed});

  final Deck deck;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(deck.title),
      onTap: onPressed,
      trailing: IconButton(
        onPressed: () => context.goNamed(
          AppRoute.edit.name,
          queryParameters: {'deckId': deck.id},
        ),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
