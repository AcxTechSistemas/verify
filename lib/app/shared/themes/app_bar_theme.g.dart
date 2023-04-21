part of 'theme.dart';

AppBarTheme get _lightAppBarTheme => AppBarTheme(
      surfaceTintColor: _lightColorScheme.onInverseSurface,
      foregroundColor: _lightColorScheme.primary,
      centerTitle: true,
      backgroundColor: _lightColorScheme.onInverseSurface,
      elevation: 0,
      iconTheme: IconThemeData(
        color: _lightColorScheme.primary,
      ),
    );
AppBarTheme get _darkAppBarTheme => AppBarTheme(
      surfaceTintColor: _darkColorScheme.onInverseSurface,
      foregroundColor: _darkColorScheme.primary,
      centerTitle: true,
      backgroundColor: _darkColorScheme.onInverseSurface,
      elevation: 0,
      iconTheme: IconThemeData(
        color: _darkColorScheme.primary,
      ),
    );
