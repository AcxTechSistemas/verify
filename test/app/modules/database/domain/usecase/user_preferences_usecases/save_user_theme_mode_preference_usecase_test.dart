import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late SaveUserThemeModePreferencesUseCase saveUserThemeModePreferencesUseCase;
  late UserPreferencesRepository userPreferencesRepository;
  late ThemeMode themeMode;
  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    saveUserThemeModePreferencesUseCase =
        SaveUserThemeModePreferencesUseCaseImpl(
      userPreferencesRepository,
    );
    themeMode = ThemeMode.dark;
    registerFallbackValue(themeMode);
  });

  group('SaveUserThemeModePreferencesUseCase: ', () {
    test('Should return success on saveUserThemePreference', () async {
      when(
        () => userPreferencesRepository.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async => const Success(Void));

      final response = await saveUserThemeModePreferencesUseCase(
        themeMode: themeMode,
      );
      verify(() => userPreferencesRepository.saveUserThemePreference(
          themeMode: themeMode)).called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return UserThemePreferenceError on saveUserThemePreference',
        () async {
      when(
        () => userPreferencesRepository.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async => Failure(
            UserThemePreferenceError(message: ''),
          ));

      final response = await saveUserThemeModePreferencesUseCase(
        themeMode: themeMode,
      );
      verify(() => userPreferencesRepository.saveUserThemePreference(
          themeMode: themeMode)).called(1);

      expect(response.isError(), true);
    });
  });
}
