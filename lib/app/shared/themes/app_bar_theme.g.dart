part of 'theme.dart';

AppBarTheme get _lightAppBarTheme => AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      surfaceTintColor: _lightColorScheme.onInverseSurface,
      foregroundColor: _lightColorScheme.primary,
      centerTitle: true,
      backgroundColor: _lightColorScheme.onInverseSurface,
      iconTheme: IconThemeData(
        color: _lightColorScheme.primary,
      ),
    );
AppBarTheme get _darkAppBarTheme => AppBarTheme(
      scrolledUnderElevation: 0,
      elevation: 0,
      surfaceTintColor: _darkColorScheme.onInverseSurface,
      foregroundColor: _darkColorScheme.primary,
      centerTitle: true,
      backgroundColor: _darkColorScheme.onInverseSurface,
      iconTheme: IconThemeData(
        color: _darkColorScheme.primary,
      ),
    );
