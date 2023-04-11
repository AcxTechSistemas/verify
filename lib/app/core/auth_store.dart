import 'package:verify/app/features/auth/domain/entities/logged_user_entity.dart';
import 'package:verify/app/features/auth/domain/usecase/logout_usecase.dart';

abstract class AuthStore {
  final LoggedUserEntity getLoggedUser;
  final LogoutUseCase logout;
  AuthStore({
    required this.getLoggedUser,
    required this.logout,
  });
}
