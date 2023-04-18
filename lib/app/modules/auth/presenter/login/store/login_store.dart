import 'package:mobx/mobx.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  @observable
  bool loginButtonEnabled = false;

  @observable
  bool loggingInWithEmail = false;

  @observable
  bool loggingInWithGoogle = false;

  @action
  isValidFields(bool isValidFields) {
    loginButtonEnabled = false;
    loginButtonEnabled = isValidFields;
  }

  @action
  loggingInWithEmailInProgress(bool logging) {
    loggingInWithEmail = false;
    loggingInWithEmail = logging;
  }

  @action
  loggingInWithGoogleInProgress(bool logging) {
    loggingInWithGoogle = false;
    loggingInWithGoogle = logging;
  }
}
