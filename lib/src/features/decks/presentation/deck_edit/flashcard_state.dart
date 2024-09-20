/// State class to encapsulate state data for the deck edit screen.
library;

import 'package:flashcard_pet/src/features/study/domain/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class FlashcardState {
  FlashcardState({
    this.originalFlashcard,
    required this.frontController,
    required this.backController,
  });

  final Flashcard? originalFlashcard;
  final QuillController frontController;
  late final QuillController backController;

  factory FlashcardState.empty() => FlashcardState(
        frontController: QuillController.basic(),
        backController: QuillController.basic(),
      );

  factory FlashcardState.fromFlashcard(Flashcard flashcard) => FlashcardState(
        originalFlashcard: flashcard,
        frontController: QuillController(
          document: Document.fromDelta(
              flashcard.frontContent.toDelta()), // ensure deep-copy
          selection: const TextSelection.collapsed(offset: 0),
        ),
        backController: QuillController(
          document: Document.fromDelta(
              flashcard.backContent.toDelta()), // ensure deep-copy
          selection: const TextSelection.collapsed(offset: 0),
        ),
      );

  FlashcardState copyWith({
    Flashcard? originalFlashcard,
    QuillController? frontController,
    QuillController? backController,
  }) {
    return FlashcardState(
      originalFlashcard: originalFlashcard ?? this.originalFlashcard,
      frontController: frontController ?? this.frontController,
      backController: backController ?? this.backController,
    );
  }
}

extension FlashcardStateX on FlashcardState {
  Document? get initialFront => originalFlashcard?.frontContent;
  Document? get initialBack => originalFlashcard?.backContent;

  bool get isModified {
    if (originalFlashcard == null) {
      return true;
    }

    return initialFront!.toDelta() != frontController.document.toDelta() ||
        initialBack!.toDelta() != backController.document.toDelta();
  }
}
