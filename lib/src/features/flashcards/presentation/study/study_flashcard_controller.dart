import 'package:flashcard_pet/src/features/flashcards/application/study_flashcard_service.dart';
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
    final flashcards = await ref.watch(flashcardsToStudyStreamProvider.future);

    return StudyFlashcardState(
      currentCard: flashcards.firstOrNull,
      remainingCount: flashcards.length,
      isFlipped: false,
    );
  }

  Future<void> loadNextCard() async {
    state = const AsyncLoading();

    final studyFlashcardService = ref.read(studyFlashcardServiceProvider);
    await studyFlashcardService.moveToNextCard();
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
