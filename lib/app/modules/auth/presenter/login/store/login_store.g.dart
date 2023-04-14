// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginStore on LoginStoreBase, Store {
  late final _$loginButtonEnabledAtom =
      Atom(name: 'LoginStoreBase.loginButtonEnabled', context: context);

  @override
  bool get loginButtonEnabled {
    _$loginButtonEnabledAtom.reportRead();
    return super.loginButtonEnabled;
  }

  @override
  set loginButtonEnabled(bool value) {
    _$loginButtonEnabledAtom.reportWrite(value, super.loginButtonEnabled, () {
      super.loginButtonEnabled = value;
    });
  }

  late final _$loggingInWithEmailAtom =
      Atom(name: 'LoginStoreBase.loggingInWithEmail', context: context);

  @override
  bool get loggingInWithEmail {
    _$loggingInWithEmailAtom.reportRead();
    return super.loggingInWithEmail;
  }

  @override
  set loggingInWithEmail(bool value) {
    _$loggingInWithEmailAtom.reportWrite(value, super.loggingInWithEmail, () {
      super.loggingInWithEmail = value;
    });
  }

  late final _$loggingInWithGoogleAtom =
      Atom(name: 'LoginStoreBase.loggingInWithGoogle', context: context);

  @override
  bool get loggingInWithGoogle {
    _$loggingInWithGoogleAtom.reportRead();
    return super.loggingInWithGoogle;
  }

  @override
  set loggingInWithGoogle(bool value) {
    _$loggingInWithGoogleAtom.reportWrite(value, super.loggingInWithGoogle, () {
      super.loggingInWithGoogle = value;
    });
  }

  late final _$LoginStoreBaseActionController =
      ActionController(name: 'LoginStoreBase', context: context);

  @override
  dynamic isValidFields(bool isValidFields) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.isValidFields');
    try {
      return super.isValidFields(isValidFields);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loggingInWithEmailInProgress(bool logging) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.loggingInWithEmailInProgress');
    try {
      return super.loggingInWithEmailInProgress(logging);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic loggingInWithGoogleInProgress(bool logging) {
    final _$actionInfo = _$LoginStoreBaseActionController.startAction(
        name: 'LoginStoreBase.loggingInWithGoogleInProgress');
    try {
      return super.loggingInWithGoogleInProgress(logging);
    } finally {
      _$LoginStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginButtonEnabled: ${loginButtonEnabled},
loggingInWithEmail: ${loggingInWithEmail},
loggingInWithGoogle: ${loggingInWithGoogle}
    ''';
  }
}
