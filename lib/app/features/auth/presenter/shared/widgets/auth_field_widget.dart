import 'package:flutter/material.dart';

class AuthFieldWidget extends StatefulWidget {
  final String labelText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool isSecret;
  final TextInputType? keyboardType;
  final void Function()? onEditingComplete;
  const AuthFieldWidget({
    super.key,
    required this.labelText,
    this.validator,
    this.isSecret = false,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
  });

  @override
  State<AuthFieldWidget> createState() => _AuthFieldWidgetState();
}

class _AuthFieldWidgetState extends State<AuthFieldWidget> {
  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onEditingComplete: widget.onEditingComplete,
      focusNode: widget.focusNode,
      controller: widget.controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      obscureText: widget.isSecret ? isObscure : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        suffixIcon: Visibility(
          visible: widget.isSecret,
          child: IconButton(
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            },
            icon: isObscure
                ? const Icon(Icons.visibility)
                : const Icon(
                    Icons.visibility_off,
                  ),
          ),
        ),
      ),
    );
  }
}
