import 'package:flutter/material.dart';
part 'color_schemes.g.dart';
part 'app_bar_theme.g.dart';
part 'input_decoration_theme.g.dart';
part 'filled_button_theme.g.dart';
part 'icon_theme.g.dart';
part 'icon_button_theme.g.dart';
part 'radio_button_theme.g.dart';
part 'navigation_bar_theme.g.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _lightColorScheme.background,
      radioTheme: _lightRadioTheme,
      colorScheme: _lightColorScheme,
      iconButtonTheme: _lightIconButtonTheme,
      iconTheme: _lightIconThemeData,
      inputDecorationTheme: _lightInputDecoration,
      filledButtonTheme: _lightFilledButtonThemeData,
      appBarTheme: _lightAppBarTheme,
      navigationBarTheme: _lightNavigationBarTheme,
    );

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _darkColorScheme.background,
      radioTheme: _darkRadioTheme,
      colorScheme: _darkColorScheme,
      iconTheme: _darkIconThemeData,
      iconButtonTheme: _darkIconButtonTheme,
      inputDecorationTheme: _darkInputDecoration,
      filledButtonTheme: _darkFilledButtonThemeData,
      appBarTheme: _darkAppBarTheme,
      navigationBarTheme: _darkNavigationBarTheme,
    );
