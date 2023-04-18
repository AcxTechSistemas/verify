import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:verify/app/modules/auth/domain/entities/logged_user_info.dart';
import 'package:verify/app/modules/auth/domain/usecase/get_logged_user_usecase.dart';
part 'auth_store.g.dart';

class AuthStore = AuthStoreBase with _$AuthStore;

abstract class AuthStoreBase with Store {
  @observable
  bool loading = false;

  @observable
  LoggedUserInfoEntity? loggedUser;

  @action
  void setUser(LoggedUserInfoEntity? user) {
    loggedUser = user;
  }

  @action
  Future<void> loadData() async {
    loading = true;
    final useCase = Modular.get<GetLoggedUserUseCase>();
    final user = await useCase();
    loggedUser = user;
    loading = false;
  }
}
