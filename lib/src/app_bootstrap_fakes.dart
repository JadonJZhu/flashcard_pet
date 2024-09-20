import 'package:flashcard_pet/src/exceptions/async_error_logger.dart';
import 'package:flashcard_pet/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flashcard_pet/src/features/study/data/fake_flashcards_repository.dart';
import 'package:flashcard_pet/src/features/study/data/flashcards_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<ProviderContainer> createFakesProviderContainer(
    {bool addDelay = true}) async {
  final authRepository = FakeAuthRepository(addDelay: addDelay);
  final flashcardsRepository = FakeFlashcardsRepository(addDelay: addDelay);

  return ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(authRepository),
      flashcardsRepositoryProvider.overrideWithValue(flashcardsRepository),
    ],
    observers: [
      AsyncErrorLogger(),
    ],
  );
}
