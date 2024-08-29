import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flashcard_pet/src/utils/delay.dart';
import 'package:flashcard_pet/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fake_decks_repository.g.dart';

class FakeDecksRepository {
  FakeDecksRepository({
    this.addDelay = true,
  });

  final bool addDelay;

  final _decks = InMemoryStore<Map<DeckID, Deck>>(kDecks);

  Stream<List<Deck>> watchDecks() {
    return _decks.stream.map(
      (deckMap) => deckMap.values.toList(),
    );
  }

  Future<List<Deck>> fetchDecks() async {
    await delay(addDelay);
    return _decks.value.values.toList();
  }
}

@riverpod
FakeDecksRepository decksRepository(DecksRepositoryRef ref) {
  return FakeDecksRepository();
}

@riverpod
Stream<List<Deck>> decksListStream(DecksListStreamRef ref) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.watchDecks();
}

@riverpod
Future<List<Deck>> decksListFuture(DecksListFutureRef ref) {
  final decksRepository = ref.watch(decksRepositoryProvider);
  return decksRepository.fetchDecks();
}
