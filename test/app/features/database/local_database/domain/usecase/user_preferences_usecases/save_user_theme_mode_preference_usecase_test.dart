import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/repository/local_database_repository.dart';
import 'package:verify/app/features/database/local_database/domain/usecase/user_preferences_usecases/save_user_theme_mode_preference_usecase.dart';

class MockLocalDataBaseRepository extends Mock
    implements LocalDataBaseRepository {}

void main() {
  late SaveUserThemeModePreferencesUseCase saveUserThemeModePreferencesUseCase;
  late LocalDataBaseRepository localDataBaseRepository;
  late ThemeMode themeMode;
  setUp(() {
    localDataBaseRepository = MockLocalDataBaseRepository();
    saveUserThemeModePreferencesUseCase =
        SaveUserThemeModePreferencesUseCaseImpl(
      localDataBaseRepository,
    );
    themeMode = ThemeMode.dark;

    registerFallbackValue(themeMode);
  });

  group('SaveUserThemeModePreferencesUseCase: ', () {
    test('Verify called saveUserThemePreference and return Success', () async {
      when(
        () => localDataBaseRepository.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async => const Success(Void));

      final response = await saveUserThemeModePreferencesUseCase(
        themeMode: themeMode,
      );

      expect(response.isSuccess(), true);

      verify(() => localDataBaseRepository.saveUserThemePreference(
          themeMode: any(named: 'themeMode'))).called(1);
    });
  });
}
