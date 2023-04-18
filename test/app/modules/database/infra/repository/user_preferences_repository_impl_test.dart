import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';
import 'package:verify/app/modules/database/infra/datasource/user_preferences_datasource.dart';
import 'package:verify/app/modules/database/infra/repository/user_preferences_repository_impl.dart';

class MockUserPreferencesDataSource extends Mock
    implements UserPreferencesDataSource {}

void main() {
  late UserPreferencesRepository userPreferencesRepository;
  late UserPreferencesDataSource userPreferencesDataSource;
  late ThemeMode themeMode;

  setUp(() {
    userPreferencesDataSource = MockUserPreferencesDataSource();
    userPreferencesRepository =
        UserPreferencesRepositoryImpl(userPreferencesDataSource);
    themeMode = ThemeMode.dark;
    registerFallbackValue(themeMode);
  });
  group('UserPreferencesRepositoryImpl: ', () {
    test('Should return success on saveUserThemePreference', () async {
      when(
        () => userPreferencesDataSource.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async {});

      final response = await userPreferencesRepository.saveUserThemePreference(
        themeMode: themeMode,
      );

      verify(
        () => userPreferencesDataSource.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      );
      expect(response.isSuccess(), true);
    });
    test('Should return UserThemePreferenceError on saveUserThemePreference',
        () async {
      when(
        () => userPreferencesDataSource.saveUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenThrow(Exception());
      const expectedResponse =
          'Não foi possivel salvar sua preferencia de tema. Tente novamente';

      final response = await userPreferencesRepository.saveUserThemePreference(
        themeMode: themeMode,
      );

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.message, equals(expectedResponse));
    });
    test('Should return ThemeMode on readUserThemePreference', () async {
      when(
        () => userPreferencesDataSource.readUserThemePreference(),
      ).thenAnswer((_) async => ThemeMode.dark);

      final response =
          await userPreferencesRepository.readUserThemePreference();
      final result = response.getOrNull();

      expect(result, isNotNull);
      expect(result, equals(ThemeMode.dark));
    });
    test('Should return UserThemePreferenceError on readUserThemePreference',
        () async {
      when(
        () => userPreferencesDataSource.readUserThemePreference(),
      ).thenThrow(Exception());
      const expectedResponse =
          'Não foi possivel recuperar sua preferencia de tema. Tente novamente';

      final response =
          await userPreferencesRepository.readUserThemePreference();

      final result = response.exceptionOrNull();

      expect(result, isNotNull);
      expect(result!.message, equals(expectedResponse));
    });
    test('Should return success on updateUserThemePreference', () async {
      when(
        () => userPreferencesDataSource.updateUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenAnswer((_) async {});

      final response =
          await userPreferencesRepository.updateUserThemePreference(
        themeMode: themeMode,
      );

      verify(
        () => userPreferencesDataSource.updateUserThemePreference(
            themeMode: any(named: 'themeMode')),
      );
      expect(response.isSuccess(), true);
    });
    test('Should return UserThemePreferenceError on updateUserThemePreference',
        () async {
      when(
        () => userPreferencesDataSource.updateUserThemePreference(
            themeMode: any(named: 'themeMode')),
      ).thenThrow(Exception());
      const expectedResponse =
          'Não foi possivel atualizar sua preferencia de tema. Tente novamente';

      final response =
          await userPreferencesRepository.updateUserThemePreference(
        themeMode: themeMode,
      );

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.message, equals(expectedResponse));
    });
    test('Should return success on deleteUserThemePreference', () async {
      when(
        () => userPreferencesDataSource.deleteUserThemePreference(),
      ).thenAnswer((_) async {});

      final response =
          await userPreferencesRepository.deleteUserThemePreference();

      verify(
        () => userPreferencesDataSource.deleteUserThemePreference(),
      );
      expect(response.isSuccess(), true);
    });
    test('Should return UserThemePreferenceError on deleteUserThemePreference',
        () async {
      when(
        () => userPreferencesDataSource.deleteUserThemePreference(),
      ).thenThrow(Exception());
      const expectedResponse =
          'Não foi possivel remover sua preferencia de tema. Tente novamente';

      final response =
          await userPreferencesRepository.deleteUserThemePreference();

      final result = response.exceptionOrNull();
      expect(result, isNotNull);
      expect(result!.message, equals(expectedResponse));
    });
  });
}
