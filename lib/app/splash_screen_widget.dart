import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verify/app/shared/themes/theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/svg/logo.svg'),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Rapido, Simples e Seguro!',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            CircularProgressIndicator(
              color: lightTheme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
