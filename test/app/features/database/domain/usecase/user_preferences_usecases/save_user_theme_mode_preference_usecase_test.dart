import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/features/database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';

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
    test('Verify called saveUserThemePreference and return Success', () async {
      when(
        () => userPreferencesRepository.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async => const Success(Void));

      final response = await saveUserThemeModePreferencesUseCase(
        themeMode: themeMode,
      );

      expect(response.isSuccess(), true);

      verify(() => userPreferencesRepository.saveUserThemePreference(
          themeMode: any(named: 'themeMode'))).called(1);
    });
  });
}
