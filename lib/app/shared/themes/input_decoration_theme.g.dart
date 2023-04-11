part of 'theme.dart';

InputDecorationTheme get _lightInputDecoration => InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _lightColorScheme.primary,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _lightColorScheme.primary,
        ),
      ),
    );

InputDecorationTheme get _darkInputDecoration => InputDecorationTheme(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _darkColorScheme.primary,
        ),
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide(
          color: _darkColorScheme.primary,
        ),
      ),
    );
