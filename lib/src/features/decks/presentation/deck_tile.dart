import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flutter/material.dart';

class DeckTile extends StatelessWidget {
  const DeckTile({super.key, required this.deck, required this.onPressed});

  final Deck deck;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(deck.title),
      onTap: onPressed,
      
    );
  }
}
