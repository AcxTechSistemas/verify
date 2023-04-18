import 'package:mobx/mobx.dart';

part 'bb_settings_store.g.dart';

class BBSettingsStore = BBSettingsStoreBase with _$BBSettingsStore;

abstract class BBSettingsStoreBase with Store {
  @observable
  bool isValidatingCredentials = false;
  @observable
  bool isSavingInCloud = false;
  @observable
  bool isSavingInLocal = false;
  @observable
  bool isValidFields = false;

  @action
  void setValidFields(bool validFields) {
    isValidFields = false;
    isValidFields = validFields;
  }

  @action
  void validatingCredentials(bool validating) {
    isValidatingCredentials = false;
    isValidatingCredentials = validating;
  }

  @action
  void savingInCloud(bool saving) {
    isSavingInCloud = false;
    isSavingInCloud = saving;
  }

  @action
  void savingInLocal(bool saving) {
    isSavingInLocal = false;
    isSavingInLocal = saving;
  }
}
