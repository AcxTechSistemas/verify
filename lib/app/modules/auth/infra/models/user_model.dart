import 'package:verify/app/modules/auth/domain/entities/logged_user_entity.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';

class UserModel extends LoggedUserEntity implements LoggedUserInfoEntity {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.emailVerified,
  });

  LoggedUserEntity toLoggedUser() => this;
}
