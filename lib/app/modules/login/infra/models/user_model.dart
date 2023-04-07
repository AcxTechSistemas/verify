import 'package:verify/app/modules/login/domain/entities/logged_user_entity.dart';
import 'package:verify/app/modules/login/domain/entities/logged_user_info.dart';

class UserModel extends LoggedUserEntity implements LoggedUserInfoEntity {
  UserModel({
    required super.email,
    required super.name,
  });

  LoggedUserEntity toLoggedUser() => this;
}
