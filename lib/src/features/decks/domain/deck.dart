// ignore_for_file: public_member_api_docs, sort_constructors_first
typedef DeckID = String;

class Deck {
  const Deck({
    required this.id,
    required this.title,
  });

  final DeckID id;
  final String title;

  Deck copyWith({
    DeckID? id,
    String? title,
  }) {
    return Deck(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }
}
