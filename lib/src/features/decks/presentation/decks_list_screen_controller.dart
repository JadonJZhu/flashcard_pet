import 'package:flashcard_pet/src/features/decks/data/fake_decks_repository.dart';
import 'package:flashcard_pet/src/features/decks/domain/deck.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'decks_list_screen_controller.g.dart';

@riverpod
class DecksListScreenController extends _$DecksListScreenController {
  @override
  Future<List<Deck>> build() async {
    final decks = await ref.watch(decksListStreamProvider.future);
    return decks;
  }

}
