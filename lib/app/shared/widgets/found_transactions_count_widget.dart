import 'package:flutter/material.dart';

class FoundTransactionsCountWidget extends StatelessWidget {
  final int length;
  const FoundTransactionsCountWidget({super.key, required this.length});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Transações encontradas',
            style: textTheme.titleSmall!.copyWith(
              color: colorScheme.outline,
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.symmetric(
              vertical: 1,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              length.toString(),
              style: textTheme.titleSmall!.copyWith(
                color: colorScheme.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
