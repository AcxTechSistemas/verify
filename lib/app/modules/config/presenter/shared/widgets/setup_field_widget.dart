import 'package:flutter/material.dart';

class SetupFieldWidget extends StatelessWidget {
  final String title;
  final String? initialValue;
  final TextEditingController controller;
  final void Function()? onPressed;
  final Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  const SetupFieldWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.controller,
    this.validator,
    this.focusNode,
    this.onEditingComplete,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      initialValue: initialValue,
      obscureText: initialValue != null,
      focusNode: focusNode,
      validator: validator,
      onEditingComplete: onEditingComplete,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: title,
        enabledBorder: const OutlineInputBorder(),
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
