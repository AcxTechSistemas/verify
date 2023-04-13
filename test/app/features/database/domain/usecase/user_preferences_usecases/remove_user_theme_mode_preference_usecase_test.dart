import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/features/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/features/database/domain/usecase/user_preferences_usecases/remove_user_theme_mode_preference_usecase.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late RemoveUserThemeModePreferencesUseCase
      removeUserThemeModePreferencesUseCase;
  late UserPreferencesRepository userPreferencesRepository;
  late ThemeMode themeMode;
  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    removeUserThemeModePreferencesUseCase =
        RemoveUserThemeModePreferencesUseCaseImpl(
      userPreferencesRepository,
    );
    themeMode = ThemeMode.dark;
    registerFallbackValue(themeMode);
  });

  group('RemoveUserThemeModePreferencesUseCase: ', () {
    test('Should return success on updateUserThemePreference', () async {
      when(
        () => userPreferencesRepository.deleteUserThemePreference(),
      ).thenAnswer((_) async => const Success(Void));

      final response = await removeUserThemeModePreferencesUseCase();
      verify(() => userPreferencesRepository.deleteUserThemePreference())
          .called(1);

      expect(response.isSuccess(), true);
    });

    test('Should return UserThemePreferenceError on updateUserThemePreference',
        () async {
      when(
        () => userPreferencesRepository.deleteUserThemePreference(),
      ).thenAnswer((_) async => Failure(
            UserThemePreferenceError(message: ''),
          ));

      final response = await removeUserThemeModePreferencesUseCase();
      verify(() => userPreferencesRepository.deleteUserThemePreference())
          .called(1);

      expect(response.isError(), true);
    });
  });
}
