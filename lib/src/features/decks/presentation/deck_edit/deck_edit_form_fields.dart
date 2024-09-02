import 'package:flashcard_pet/src/common_widgets/responsive_two_column_layout.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/constants/breakpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class TitleField extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const TitleField({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

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
  final quill.Document initialFront;
  final quill.Document initialBack;
  final ValueChanged<quill.Document> onChangedFront;
  final ValueChanged<quill.Document> onChangedBack;
  final VoidCallback onDelete;
  final int index;

  const FlashcardField({
    super.key,
    required this.initialFront,
    required this.initialBack,
    required this.onChangedFront,
    required this.onChangedBack,
    required this.onDelete,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            foregroundColor: Colors.black,
            child: Text('$index'),
          ),
          gapW8,
          Expanded(
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
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class FlashcardSideField extends StatefulWidget {
  final quill.Document initialValue;
  final String labelText;
  final ValueChanged<quill.Document> onChanged;

  const FlashcardSideField({
    super.key,
    required this.initialValue,
    required this.labelText,
    required this.onChanged,
  });

  @override
  State<FlashcardSideField> createState() => _FlashcardSideFieldState();
}

class _FlashcardSideFieldState extends State<FlashcardSideField> {
  late quill.QuillController _controller;

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController(
      document: widget.initialValue,
      selection: const TextSelection.collapsed(offset: 0),
    );
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    widget.onChanged(_controller.document);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTextChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Container(
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
          child: quill.QuillEditor.basic(
            controller: _controller,
            scrollController: ScrollController(),
          ),
        ),
        quill.QuillSimpleToolbar(
          configurations: const quill.QuillSimpleToolbarConfigurations(),
          controller: _controller,
        ),
      ],
    );
  }
}
