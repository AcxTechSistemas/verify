import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/domain/usecase/user_preferences_usecases/read_user_theme_mode_preference_usecase.dart';

class MockUserPreferencesRepository extends Mock
    implements UserPreferencesRepository {}

void main() {
  late ReadUserThemeModePreferencesUseCase readUserThemeModePreferencesUseCase;
  late UserPreferencesRepository userPreferencesRepository;
  late ThemeMode themeMode;
  setUp(() {
    userPreferencesRepository = MockUserPreferencesRepository();
    readUserThemeModePreferencesUseCase =
        ReadUserThemeModePreferencesUseCaseImpl(
      userPreferencesRepository,
    );
    themeMode = ThemeMode.dark;
    registerFallbackValue(themeMode);
  });

  group('ReadUserThemeModePreferencesUseCase: ', () {
    test('Should return ThemeMode on saveUserThemePreference', () async {
      when(
        () => userPreferencesRepository.readUserThemePreference(),
      ).thenAnswer((_) async => const Success(ThemeMode.dark));

      final response = await readUserThemeModePreferencesUseCase();

      final result = response.getOrNull();

      expect(result, isNotNull);
    });

    test('Should return UserThemePreferenceError on readUserThemePreference',
        () async {
      when(
        () => userPreferencesRepository.readUserThemePreference(),
      ).thenAnswer((_) async => Failure(
            UserThemePreferenceError(message: ''),
          ));

      final response = await readUserThemeModePreferencesUseCase();

      verify(() => userPreferencesRepository.readUserThemePreference())
          .called(1);

      expect(response.isError(), true);
    });
  });
}
