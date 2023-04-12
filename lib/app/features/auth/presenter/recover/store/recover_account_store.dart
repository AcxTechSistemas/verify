import 'package:mobx/mobx.dart';

part 'recover_account_store.g.dart';

class RecoverAccountPageStore = RecoverAccountPageStoreBase
    with _$RecoverAccountPageStore;

abstract class RecoverAccountPageStoreBase with Store {
  @observable
  bool enableRecoverButton = false;

  @observable
  bool recovertingWithEmail = false;

  @action
  void validateField(bool isValidFields) {
    enableRecoverButton = false;
    enableRecoverButton = isValidFields;
  }

  @action
  void recoveringWithEmailInProgress(bool recovering) {
    recovertingWithEmail = false;
    recovertingWithEmail = recovering;
  }
}
