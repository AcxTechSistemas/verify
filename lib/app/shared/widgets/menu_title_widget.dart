import 'package:flutter/material.dart';

class MenuTitleWidget extends StatelessWidget {
  final String title;
  const MenuTitleWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Text(
      title,
      textAlign: TextAlign.start,
      style: textTheme.titleSmall!.copyWith(
        color: colorScheme.outline,
      ),
    );
  }
}
