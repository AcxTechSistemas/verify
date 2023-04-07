import 'package:verify/app/modules/login/domain/entities/login_credentials_entity.dart';
import 'package:verify/app/modules/login/infra/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> loginWithEmail(
    LoginCredentialsEntity loginCredentialsEntity,
  );
  Future<UserModel> loginWithGoogle();
  Future<UserModel> currentUser();
  Future<void> logout();
}
