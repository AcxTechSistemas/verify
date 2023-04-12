import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/errors/user_preferences_error.dart';

abstract class LocalDataBaseRepository {
  // User Preferences
  Future<Result<void, UserPreferencesError>> saveUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<Result<void, UserPreferencesError>> updateUserThemePreference({
    required ThemeMode themeMode,
  });
  Future<Result<ThemeMode, UserPreferencesError>> readUserThemePreference();
  Future<Result<void, UserPreferencesError>> deleteUserThemePreference();

  // SicoobApiCredentials
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials({
    required SicoobApiCredentialsEntity sicoobApiCredentialsEntity,
  });
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials();

  // BBApiCredentials
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials({
    required BBApiCredentialsEntity bbApiCredentialsEntity,
  });
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials();
}
