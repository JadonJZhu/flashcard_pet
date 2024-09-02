import 'package:flashcard_pet/src/utils/in_memory_store.dart';

Future<void> delay([bool addDelay = true, int milliseconds = 1000]) {
  if (addDelay) {
    return Future.delayed(Duration(milliseconds: milliseconds));
  } else {
    return Future.value();
  }
}

Future<void> fakeAsyncMutationCallback<T>(
    {required InMemoryStore<T> inMemoryStore,
    required Function(T) callback}) async {
  await delay();
  final value = inMemoryStore.value;
  callback(value);
inMemoryStore.update(value);
}
