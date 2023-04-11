part of 'theme.dart';

RadioThemeData get _lightRadioTheme => RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _lightColorScheme.primary;
        } else {
          return _lightColorScheme.secondary;
        }
      }),
    );

RadioThemeData get _darkRadioTheme => RadioThemeData(
      fillColor: MaterialStateColor.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return _darkColorScheme.primary;
        } else {
          return _darkColorScheme.secondary;
        }
      }),
    );
