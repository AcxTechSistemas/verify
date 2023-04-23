import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyAccountWidget extends StatelessWidget {
  const EmptyAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return LayoutBuilder(builder: (context, constraints) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Configure sua conta para ter acesso aos nossos serviços',
              textAlign: TextAlign.center,
              style: textTheme.titleMedium!.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Lottie.asset(
                'assets/animations/emptyAccounts.json',
              ),
            ),
          ],
        ),
      );
    });
  }
}
