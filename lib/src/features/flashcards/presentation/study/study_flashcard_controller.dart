import 'package:flashcard_pet/src/features/flashcards/data/flashcards_repository.dart';
import 'package:flashcard_pet/src/features/flashcards/domain/flashcard.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'study_flashcard_controller.g.dart';

@riverpod
class StudyFlashcardController extends _$StudyFlashcardController {
  @override
  Future<StudyFlashcardState> build() {

    return _loadStudyInfo();
  }

  Future<StudyFlashcardState> _loadStudyInfo() async {
    final flashcards = await ref.watch(dueFlashcardsStreamProvider.future);

    return StudyFlashcardState(
      currentCard: flashcards.firstOrNull,
      remainingCount: flashcards.length,
      isFlipped: false,
    );
  }

  void flipCard() {
    state = AsyncValue.data(
        state.value!.copyWith(isFlipped: !state.value!.isFlipped));
  }
}

class StudyFlashcardState {
  StudyFlashcardState({
    required this.currentCard,
    required this.remainingCount,
    required this.isFlipped,
  });

  final Flashcard? currentCard;
  final int remainingCount;
  final bool isFlipped;

  factory StudyFlashcardState.initial() => StudyFlashcardState(
        currentCard: null,
        remainingCount: 0,
        isFlipped: false,
      );

  StudyFlashcardState copyWith({
    Flashcard? currentCard,
    int? remainingCount,
    bool? isFlipped,
  }) {
    return StudyFlashcardState(
      currentCard: currentCard ?? this.currentCard,
      remainingCount: remainingCount ?? this.remainingCount,
      isFlipped: isFlipped ?? this.isFlipped,
    );
  }
}
