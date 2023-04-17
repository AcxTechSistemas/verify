// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sicoob_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SicoobSettingsStore on SicoobSettingsStoreBase, Store {
  late final _$isValidatingCredentialsAtom = Atom(
      name: 'SicoobSettingsStoreBase.isValidatingCredentials',
      context: context);

  @override
  bool get isValidatingCredentials {
    _$isValidatingCredentialsAtom.reportRead();
    return super.isValidatingCredentials;
  }

  @override
  set isValidatingCredentials(bool value) {
    _$isValidatingCredentialsAtom
        .reportWrite(value, super.isValidatingCredentials, () {
      super.isValidatingCredentials = value;
    });
  }

  late final _$isSavingInCloudAtom =
      Atom(name: 'SicoobSettingsStoreBase.isSavingInCloud', context: context);

  @override
  bool get isSavingInCloud {
    _$isSavingInCloudAtom.reportRead();
    return super.isSavingInCloud;
  }

  @override
  set isSavingInCloud(bool value) {
    _$isSavingInCloudAtom.reportWrite(value, super.isSavingInCloud, () {
      super.isSavingInCloud = value;
    });
  }

  late final _$isSavingInLocalAtom =
      Atom(name: 'SicoobSettingsStoreBase.isSavingInLocal', context: context);

  @override
  bool get isSavingInLocal {
    _$isSavingInLocalAtom.reportRead();
    return super.isSavingInLocal;
  }

  @override
  set isSavingInLocal(bool value) {
    _$isSavingInLocalAtom.reportWrite(value, super.isSavingInLocal, () {
      super.isSavingInLocal = value;
    });
  }

  late final _$isValidFieldsAtom =
      Atom(name: 'SicoobSettingsStoreBase.isValidFields', context: context);

  @override
  bool get isValidFields {
    _$isValidFieldsAtom.reportRead();
    return super.isValidFields;
  }

  @override
  set isValidFields(bool value) {
    _$isValidFieldsAtom.reportWrite(value, super.isValidFields, () {
      super.isValidFields = value;
    });
  }

  late final _$certificateFileNameAtom = Atom(
      name: 'SicoobSettingsStoreBase.certificateFileName', context: context);

  @override
  String get certificateFileName {
    _$certificateFileNameAtom.reportRead();
    return super.certificateFileName;
  }

  @override
  set certificateFileName(String value) {
    _$certificateFileNameAtom.reportWrite(value, super.certificateFileName, () {
      super.certificateFileName = value;
    });
  }

  late final _$SicoobSettingsStoreBaseActionController =
      ActionController(name: 'SicoobSettingsStoreBase', context: context);

  @override
  void setValidFields(bool validFields) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.setValidFields');
    try {
      return super.setValidFields(validFields);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCertificateFileName(String validFields) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.setCertificateFileName');
    try {
      return super.setCertificateFileName(validFields);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatingCredentials(bool validating) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.validatingCredentials');
    try {
      return super.validatingCredentials(validating);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void savingInCloud(bool saving) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.savingInCloud');
    try {
      return super.savingInCloud(saving);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void savingInLocal(bool saving) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.savingInLocal');
    try {
      return super.savingInLocal(saving);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isValidatingCredentials: ${isValidatingCredentials},
isSavingInCloud: ${isSavingInCloud},
isSavingInLocal: ${isSavingInLocal},
isValidFields: ${isValidFields},
certificateFileName: ${certificateFileName}
    ''';
  }
}
