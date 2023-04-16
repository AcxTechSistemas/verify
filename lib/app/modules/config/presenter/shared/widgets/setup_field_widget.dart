import 'package:flutter/material.dart';

class SetupFieldWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final void Function()? onPressed;
  final String? Function(String?)? validator;
  const SetupFieldWidget({
    super.key,
    this.onPressed,
    required this.title,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
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
