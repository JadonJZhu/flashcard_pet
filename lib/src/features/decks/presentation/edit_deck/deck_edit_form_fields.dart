import 'package:flashcard_pet/src/common_widgets/responsive_two_column_layout.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';

class TitleField extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TitleField(
      {super.key, required this.initialValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: const InputDecoration(
        labelText: 'Deck Title',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a title for the deck';
        } else if (value.length > 70) {
          return 'The title must be less than 70 characters.';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

class FlashcardField extends StatelessWidget {
  final String initialFront;
  final String initialBack;
  final ValueChanged<String> onChangedFront;
  final ValueChanged<String> onChangedBack;

  const FlashcardField({
    super.key,
    required this.initialFront,
    required this.initialBack,
    required this.onChangedFront,
    required this.onChangedBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Sizes.p16),
      child: ResponsiveTwoColumnLayout(
        startContent: FlashcardSideField(
          initialValue: initialFront,
          labelText: 'Front',
          onChanged: onChangedFront,
        ),
        endContent: FlashcardSideField(
          initialValue: initialBack,
          labelText: 'Back',
          onChanged: onChangedBack,
        ),
        spacing: 16,
        breakpoint: Breakpoint.tablet,
      ),
    );
  }
}

class FlashcardSideField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  final ValueChanged<String> onChanged;

  const FlashcardSideField({
    super.key,
    required this.initialValue,
    required this.labelText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter the $labelText of the flashcard';
        }
        return null;
      },
      onChanged: onChanged,
      maxLines: 3,
    );
  }
}
