import 'package:mobx/mobx.dart';

part 'sicoob_settings_store.g.dart';

class SicoobSettingsStore = SicoobSettingsStoreBase with _$SicoobSettingsStore;

abstract class SicoobSettingsStoreBase with Store {
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
}
