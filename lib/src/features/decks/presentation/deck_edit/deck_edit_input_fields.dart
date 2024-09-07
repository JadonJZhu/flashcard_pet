import 'package:flashcard_pet/src/common_widgets/responsive_two_column_layout.dart';
import 'package:flashcard_pet/src/constants/app_sizes.dart';
import 'package:flashcard_pet/src/constants/breakpoints.dart';
import 'package:flashcard_pet/src/features/decks/presentation/deck_edit/flashcard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
    );
  }
}

class FlashcardField extends StatelessWidget {
  const FlashcardField({
    super.key,
    required this.index,
    required this.flashcardState,
    this.onDelete,
  });

  final int index;
  final FlashcardState flashcardState;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            foregroundColor: Colors.black,
            child: Text('${index + 1}'),
          ),
          gapW8,
          Expanded(
            child: ResponsiveTwoColumnLayout(
              startContent: FlashcardSideField(
                key: UniqueKey(),
                controller: flashcardState.frontController,
                labelText: 'Front',
              ),
              endContent: FlashcardSideField(
                key: UniqueKey(),
                controller: flashcardState.backController,
                labelText: 'Back',
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
  final quill.QuillController controller;
  final String labelText;

  const FlashcardSideField({
    super.key,
    required this.controller,
    required this.labelText,
  });

  @override
  State<FlashcardSideField> createState() => _FlashcardSideFieldState();
}

class _FlashcardSideFieldState extends State<FlashcardSideField> {
  late final FocusNode _editorFocusNode;
  late final FocusScopeNode _focusScopeNode;
  late final ScrollController _editorScrollController;
  bool _isEditorFocused = false;

  @override
  void initState() {
    super.initState();
    _editorFocusNode = FocusNode();
    _focusScopeNode = FocusScopeNode();
    _focusScopeNode.addListener(_onFocusChange);
    _editorScrollController = ScrollController();
    widget.controller.editorFocusNode = _editorFocusNode;
  }

  @override
  void dispose() {
    _focusScopeNode.removeListener(_onFocusChange);
    _focusScopeNode.dispose();
    _editorFocusNode.dispose();
    _editorScrollController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isEditorFocused = _focusScopeNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      node: _focusScopeNode,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.labelText,
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Container(
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: quill.QuillEditor.basic(
              controller: widget.controller,
              scrollController: _editorScrollController,
              focusNode: _editorFocusNode,
            ),
          ),
          if (_isEditorFocused)
            quill.QuillSimpleToolbar(
              configurations: const quill.QuillSimpleToolbarConfigurations(),
              controller: widget.controller,
            ),
        ],
      ),
    );
  }
}
