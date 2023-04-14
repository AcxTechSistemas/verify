// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on RegisterStoreBase, Store {
  late final _$registerButtonEnabledAtom =
      Atom(name: 'RegisterStoreBase.registerButtonEnabled', context: context);

  @override
  bool get registerButtonEnabled {
    _$registerButtonEnabledAtom.reportRead();
    return super.registerButtonEnabled;
  }

  @override
  set registerButtonEnabled(bool value) {
    _$registerButtonEnabledAtom.reportWrite(value, super.registerButtonEnabled,
        () {
      super.registerButtonEnabled = value;
    });
  }

  late final _$registeringWithEmailAtom =
      Atom(name: 'RegisterStoreBase.registeringWithEmail', context: context);

  @override
  bool get registeringWithEmail {
    _$registeringWithEmailAtom.reportRead();
    return super.registeringWithEmail;
  }

  @override
  set registeringWithEmail(bool value) {
    _$registeringWithEmailAtom.reportWrite(value, super.registeringWithEmail,
        () {
      super.registeringWithEmail = value;
    });
  }

  late final _$registeringWithGoogleAtom =
      Atom(name: 'RegisterStoreBase.registeringWithGoogle', context: context);

  @override
  bool get registeringWithGoogle {
    _$registeringWithGoogleAtom.reportRead();
    return super.registeringWithGoogle;
  }

  @override
  set registeringWithGoogle(bool value) {
    _$registeringWithGoogleAtom.reportWrite(value, super.registeringWithGoogle,
        () {
      super.registeringWithGoogle = value;
    });
  }

  late final _$RegisterStoreBaseActionController =
      ActionController(name: 'RegisterStoreBase', context: context);

  @override
  dynamic isValidFields(bool isValidFields) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.isValidFields');
    try {
      return super.isValidFields(isValidFields);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registeringWithEmailInProgress(bool logging) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.registeringWithEmailInProgress');
    try {
      return super.registeringWithEmailInProgress(logging);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic registeringWithGoogleInProgress(bool logging) {
    final _$actionInfo = _$RegisterStoreBaseActionController.startAction(
        name: 'RegisterStoreBase.registeringWithGoogleInProgress');
    try {
      return super.registeringWithGoogleInProgress(logging);
    } finally {
      _$RegisterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
registerButtonEnabled: ${registerButtonEnabled},
registeringWithEmail: ${registeringWithEmail},
registeringWithGoogle: ${registeringWithGoogle}
    ''';
  }
}
