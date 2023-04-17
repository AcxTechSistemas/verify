import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  LoggedUserInfoEntity? loggedUser;

  @action
  setUser(LoggedUserInfoEntity? user) {
    loggedUser = user;
  }
}
