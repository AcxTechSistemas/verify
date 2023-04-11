import 'package:verify/app/features/auth/domain/entities/logged_user_entity.dart';
import 'package:verify/app/features/auth/domain/entities/logged_user_info.dart';

class UserModel extends LoggedUserEntity implements LoggedUserInfoEntity {
  const UserModel({
    required super.email,
    required super.name,
    required super.validEmail,
  });

  LoggedUserEntity toLoggedUser() => this;
}
