import 'package:flashcard_pet/src/constants/dummy_data.dart';
import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeDecksRepository makeDecksRepository() => FakeDecksRepository(
        addDelay: false,
      );
  group('FakeDecksRepository', () {
    test('watchDecksList emits dummy list', () {
      final decksRepository = makeDecksRepository();
      expect(
        decksRepository.watchDecksList(),
        emits(
          kDummyDecksMap.values.toList(),
        ),
      );
    });
    test('fetchDecksList returns dummy list', () async {
      final decksRepository = makeDecksRepository();
      expect(
        await decksRepository.fetchDecksList(),
        kDummyDecksMap.values.toList(),
      );
    });
    test('fetchDeckById(1) returns deck with id 1', () async {
      final decksRepository = makeDecksRepository();
      expect(await decksRepository.fetchDeckById('1'), kDummyDecksMap['1']);
    });

    test(
      'setDeck',
      () async {
        // set up
        final decksRepository = makeDecksRepository();
        const testDeck = Deck(id: '2', title: 'haha');

        // run
        await decksRepository.setDeck(testDeck);

        // verify
        final decks = Map.of(kDummyDecksMap);
        decks[testDeck.id] = testDeck;
        expect(decksRepository.decksValue, decks);
      },
    );

    test('delete deck by id', () async {
      // set up
      final decksRepository = makeDecksRepository();
      expect(await decksRepository.fetchDeckById('1'), kDummyDecksMap['1']);

      // run
      await decksRepository.deleteDeckById('1');

      // verify
      final decks = Map.of(kDummyDecksMap);
      decks.remove('1');
      expect(decksRepository.decksValue, decks);
    });
  });
}
