part of 'theme.dart';

AppBarTheme get _lightAppBarTheme => AppBarTheme(
      foregroundColor: _lightColorScheme.primary,
      centerTitle: true,
      backgroundColor: _lightColorScheme.onInverseSurface,
      elevation: 0,
      iconTheme: IconThemeData(
        color: _lightColorScheme.primary,
      ),
    );
AppBarTheme get _darkAppBarTheme => AppBarTheme(
      foregroundColor: _darkColorScheme.primary,
      centerTitle: true,
      backgroundColor: _darkColorScheme.onInverseSurface,
      elevation: 0,
      iconTheme: IconThemeData(
        color: _darkColorScheme.primary,
      ),
    );
