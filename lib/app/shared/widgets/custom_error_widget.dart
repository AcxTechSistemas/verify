import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: colorScheme.error,
          size: 100,
          shadows: [
            Shadow(
              color: Colors.red.withOpacity(0.3),
              offset: const Offset(3, 3),
              blurRadius: 20,
            ),
          ],
        ),
        Text(
          'Ops, Algo deu errado!',
          style: textTheme.titleMedium,
        ),
        Text(
          'Por favor tente novamente',
          style: textTheme.bodyMedium,
        ),
      ],
    );
  }
}
