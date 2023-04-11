import 'package:mobx/mobx.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  @observable
  bool registerButtonEnabled = false;

  @observable
  bool registeringWithEmail = false;

  @observable
  bool registeringWithGoogle = false;

  @action
  isValidFields(bool isValidFields) {
    registerButtonEnabled = false;
    registerButtonEnabled = isValidFields;
  }

  @action
  registeringWithEmailInProgress(bool logging) {
    registeringWithEmail = false;
    registeringWithEmail = logging;
  }

  @action
  registeringWithGoogleInProgress(bool logging) {
    registeringWithGoogle = false;
    registeringWithGoogle = logging;
  }
}
