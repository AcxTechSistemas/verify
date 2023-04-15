abstract class UserPreferencesError {
  String get message;
}

class ErrorReadUserThemePreference extends UserPreferencesError {
  @override
  final String message;
  ErrorReadUserThemePreference({
    required this.message,
  });
}

class ErrorSavingUserThemePreference extends UserPreferencesError {
  @override
  final String message;
  ErrorSavingUserThemePreference({
    required this.message,
  });
}

class ErrorUpdateUserThemePreference extends UserPreferencesError {
  @override
  final String message;
  ErrorUpdateUserThemePreference({
    required this.message,
  });
}

class ErrorDeletingUserThemePreference extends UserPreferencesError {
  @override
  final String message;
  ErrorDeletingUserThemePreference({
    required this.message,
  });
}
