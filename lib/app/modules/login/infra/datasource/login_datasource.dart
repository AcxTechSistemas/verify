import 'package:verify/app/modules/login/infra/models/user_model.dart';

abstract class LoginDataSource {
  Future<UserModel> currentUser();
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });
  Future<UserModel> loginWithGoogle();
  Future<void> logout();
}
