import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeckTile extends StatelessWidget {
  const DeckTile({super.key, required this.deck});

  final Deck deck;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(deck.title),
      onTap: () => context.goNamed(
        AppRoute.study.name,
      ),
    );
  }
}
