import 'package:result_dart/result_dart.dart';
import 'package:verify/app/modules/database/domain/errors/user_preferences_error.dart';
import 'package:verify/app/modules/database/domain/repository/user_preferences_repository.dart';

abstract class RemoveUserThemeModePreferencesUseCase {
  Future<Result<void, UserPreferencesError>> call();
}

class RemoveUserThemeModePreferencesUseCaseImpl
    implements RemoveUserThemeModePreferencesUseCase {
  final UserPreferencesRepository _userPreferencesRepository;

  RemoveUserThemeModePreferencesUseCaseImpl(this._userPreferencesRepository);
  @override
  Future<Result<void, UserPreferencesError>> call() async {
    return await _userPreferencesRepository.deleteUserThemePreference();
  }
}
