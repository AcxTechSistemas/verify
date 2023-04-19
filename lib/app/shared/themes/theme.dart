import 'package:flutter/material.dart';
part 'color_schemes.g.dart';
part 'app_bar_theme.g.dart';
part 'input_decoration_theme.g.dart';
part 'filled_button_theme.g.dart';
part 'icon_theme.g.dart';
part 'icon_button_theme.g.dart';
part 'radio_button_theme.g.dart';

ThemeData get lightTheme => ThemeData(
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
      scaffoldBackgroundColor: _darkColorScheme.background,
      radioTheme: _darkRadioTheme,
      colorScheme: _darkColorScheme,
      iconTheme: _darkIconThemeData,
      iconButtonTheme: _darkIconButtonTheme,
      inputDecorationTheme: _darkInputDecoration,
      filledButtonTheme: _darkFilledButtonThemeData,
      appBarTheme: _darkAppBarTheme,
    );

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
