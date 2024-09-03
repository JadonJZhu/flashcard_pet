import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

class QuillContentDisplay extends StatelessWidget {
  final Document document;

  const QuillContentDisplay({super.key, required this.document});

  @override
  Widget build(BuildContext context) {
    return QuillEditor(
      controller: QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
        readOnly: true,
      ),
      scrollController: ScrollController(),
      focusNode: FocusNode(),
      configurations: const QuillEditorConfigurations(
        scrollable: false,
        autoFocus: false,
        expands: false,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
