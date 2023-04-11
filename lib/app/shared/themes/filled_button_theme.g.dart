part of 'theme.dart';

FilledButtonThemeData get _lightFilledButtonThemeData => FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => const Size(131, 40),
        ),
      ),
    );
FilledButtonThemeData get _darkFilledButtonThemeData => FilledButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.resolveWith<Size>(
          (states) => const Size(131, 40),
        ),
      ),
    );
