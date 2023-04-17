import 'package:mobx/mobx.dart';

part 'sicoob_settings_store.g.dart';

class SicoobSettingsStore = SicoobSettingsStoreBase with _$SicoobSettingsStore;

abstract class SicoobSettingsStoreBase with Store {
  @observable
  bool isValidatingCredentials = false;
  @observable
  bool isSavingInCloud = false;
  @observable
  bool isSavingInLocal = false;
  @observable
  bool isValidFields = false;
  @observable
  String certificateFileName = '';

  @action
  void setValidFields(bool validFields) {
    isValidFields = false;
    isValidFields = validFields;
  }

  @action
  void setCertificateFileName(String validFields) {
    certificateFileName = validFields;
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
