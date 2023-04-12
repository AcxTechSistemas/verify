// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recover_account_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RecoverAccountPageStore on RecoverAccountPageStoreBase, Store {
  late final _$enableRecoverButtonAtom = Atom(
      name: 'RecoverAccountPageStoreBase.enableRecoverButton',
      context: context);

  @override
  bool get enableRecoverButton {
    _$enableRecoverButtonAtom.reportRead();
    return super.enableRecoverButton;
  }

  @override
  set enableRecoverButton(bool value) {
    _$enableRecoverButtonAtom.reportWrite(value, super.enableRecoverButton, () {
      super.enableRecoverButton = value;
    });
  }

  late final _$recovertingWithEmailAtom = Atom(
      name: 'RecoverAccountPageStoreBase.recovertingWithEmail',
      context: context);

  @override
  bool get recovertingWithEmail {
    _$recovertingWithEmailAtom.reportRead();
    return super.recovertingWithEmail;
  }

  @override
  set recovertingWithEmail(bool value) {
    _$recovertingWithEmailAtom.reportWrite(value, super.recovertingWithEmail,
        () {
      super.recovertingWithEmail = value;
    });
  }

  late final _$RecoverAccountPageStoreBaseActionController =
      ActionController(name: 'RecoverAccountPageStoreBase', context: context);

  @override
  void validateField(bool isValidFields) {
    final _$actionInfo = _$RecoverAccountPageStoreBaseActionController
        .startAction(name: 'RecoverAccountPageStoreBase.validateField');
    try {
      return super.validateField(isValidFields);
    } finally {
      _$RecoverAccountPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void recoveringWithEmailInProgress(bool recovering) {
    final _$actionInfo =
        _$RecoverAccountPageStoreBaseActionController.startAction(
            name: 'RecoverAccountPageStoreBase.recoveringWithEmailInProgress');
    try {
      return super.recoveringWithEmailInProgress(recovering);
    } finally {
      _$RecoverAccountPageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
enableRecoverButton: ${enableRecoverButton},
recovertingWithEmail: ${recovertingWithEmail}
    ''';
  }
}
