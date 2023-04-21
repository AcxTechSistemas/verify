part of 'theme.dart';

NavigationBarThemeData get _lightNavigationBarTheme => NavigationBarThemeData(
      backgroundColor: _lightColorScheme.inverseSurface,
      indicatorColor: _lightColorScheme.secondaryContainer,
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(
            color: _lightColorScheme.primary,
          );
        }
        return null;
      }),
    );

NavigationBarThemeData get _darkNavigationBarTheme => NavigationBarThemeData(
      backgroundColor: _darkColorScheme.inverseSurface,
      indicatorColor: _darkColorScheme.secondaryContainer,
      iconTheme: MaterialStateProperty.resolveWith<IconThemeData?>((states) {
        if (states.contains(MaterialState.selected)) {
          return IconThemeData(
            color: _darkColorScheme.primary,
          );
        }
        return null;
      }),
    );
