part of 'theme.dart';

IconButtonThemeData get _lightIconButtonTheme => IconButtonThemeData(
      style: ButtonStyle(
        iconColor: MaterialStateColor.resolveWith(
            (states) => _lightColorScheme.primary),
      ),
    );
IconButtonThemeData get _darkIconButtonTheme => IconButtonThemeData(
      style: ButtonStyle(
          iconColor: MaterialStateColor.resolveWith(
        (states) => _darkColorScheme.primary,
      )),
    );
