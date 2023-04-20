import 'package:flutter/material.dart';

class TransactionsNotFoundWidget extends StatelessWidget {
  const TransactionsNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.search_off,
          color: colorScheme.primary,
          size: 70,
          shadows: [
            Shadow(
              color: colorScheme.primary.withOpacity(0.3),
              offset: const Offset(3, 3),
              blurRadius: 20,
            ),
          ],
        ),
        Text(
          'Nenhuma transação encontrada',
          style: textTheme.titleMedium,
        ),
      ],
    );
  }
}
