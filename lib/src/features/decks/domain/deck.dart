typedef DeckID = String;

class Deck {
  const Deck({
    required this.id,
    required this.title,
    this.examDate,
  });

  final DeckID id;
  final String title;
  final DateTime? examDate;

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
