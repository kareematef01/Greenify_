import 'package:flutter/material.dart';

class ChatTextFromFeild extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool isReadOnly;
  final void Function(String)? onFieldSubmitted;

  const ChatTextFromFeild({
    super.key,
    this.focusNode,
    this.controller,
    required this.isReadOnly,
    required this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      autocorrect: false,
      focusNode: focusNode,
      controller: controller,
      readOnly: isReadOnly,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(16),
        hintText: "Type a question",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
            color: Colors.green[400]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: BorderSide(
           color: Colors.green[400]!,
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your question";
        }
        return null;
      },
    );
  }
}
