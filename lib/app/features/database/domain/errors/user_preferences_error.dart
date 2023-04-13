abstract class UserPreferencesError {
  String get message;
}

class UserThemePreferenceError extends UserPreferencesError {
  @override
  final String message;
  UserThemePreferenceError({
    required this.message,
  });
}