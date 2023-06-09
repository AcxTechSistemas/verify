import 'package:flutter/material.dart';

class AuthActionButton extends StatelessWidget {
  final String title;
  final Color? color;
  final void Function()? onPressed;
  final bool isLoading;
  final bool enabled;
  const AuthActionButton({
    super.key,
    this.onPressed,
    required this.title,
    this.isLoading = false,
    this.enabled = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: color != null
              ? MaterialStateColor.resolveWith((states) => color!)
              : null),
      onPressed: enabled ? onPressed : null,
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: enabled
                    ? colorScheme.secondaryContainer
                    : colorScheme.primary,
                strokeWidth: 3,
              ),
            )
          : Text(title),
    );
  }
}
