// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sicoob_settings_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SicoobSettingsStore on SicoobSettingsStoreBase, Store {
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
  void setValidFields(bool isValidFields) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.setValidFields');
    try {
      return super.setValidFields(isValidFields);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCertificateFileName(String certificateFileName) {
    final _$actionInfo = _$SicoobSettingsStoreBaseActionController.startAction(
        name: 'SicoobSettingsStoreBase.setCertificateFileName');
    try {
      return super.setCertificateFileName(certificateFileName);
    } finally {
      _$SicoobSettingsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isValidFields: ${isValidFields},
certificateFileName: ${certificateFileName}
    ''';
  }
}
