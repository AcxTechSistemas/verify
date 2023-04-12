import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:verify/app/features/database/local_database/domain/entities/bb_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/entities/sicoob_api_credentials_entity.dart';
import 'package:verify/app/features/database/local_database/domain/errors/api_credentials_error.dart';
import 'package:verify/app/features/database/local_database/domain/errors/user_preferences_error.dart';

abstract class LocalDataBaseRepository {
  // User Preferences
  Future<Result<void, UserPreferencesError>> saveUserThemePreference();
  Future<Result<void, UserPreferencesError>> updateUserThemePreference();
  Future<Result<ThemeMode, UserPreferencesError>> readUserThemePreference();
  Future<Result<void, UserPreferencesError>> deleteUserThemePreference();

  // SicoobApiCredentials
  Future<Result<void, ApiCredentialsError>> saveSicoobApiCredentials();
  Future<Result<void, ApiCredentialsError>> updateSicoobApiCredentials();
  Future<Result<SicoobApiCredentialsEntity, ApiCredentialsError>>
      readSicoobApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeSicoobApiCredentials();

  // BBApiCredentials
  Future<Result<void, ApiCredentialsError>> saveBBApiCredentials();
  Future<Result<void, ApiCredentialsError>> updateBBApiCredentials();
  Future<Result<BBApiCredentialsEntity, ApiCredentialsError>>
      readBBApiCredentials();
  Future<Result<void, ApiCredentialsError>> removeBBApiCredentials();
}
