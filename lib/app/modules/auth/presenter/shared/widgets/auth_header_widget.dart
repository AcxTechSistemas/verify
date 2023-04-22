import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onInverseSurface,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            SvgPicture.asset(
              'assets/svg/logo.svg',
              // ignore: deprecated_member_use
              color: colorScheme.primary,
            ),
            const SizedBox(height: 16),
            const Text(
              'Rapido, Simples e Seguro!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
