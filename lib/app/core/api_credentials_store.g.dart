// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_credentials_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApiCredentialsStore on ApiCredentialsStoreBase, Store {
  Computed<bool>? _$hasApiCredentialsComputed;

  @override
  bool get hasApiCredentials => (_$hasApiCredentialsComputed ??= Computed<bool>(
          () => super.hasApiCredentials,
          name: 'ApiCredentialsStoreBase.hasApiCredentials'))
      .value;
  Computed<List<Map<String, dynamic>>?>? _$listAccountsComputed;

  @override
  List<Map<String, dynamic>>? get listAccounts => (_$listAccountsComputed ??=
          Computed<List<Map<String, dynamic>>?>(() => super.listAccounts,
              name: 'ApiCredentialsStoreBase.listAccounts'))
      .value;

  late final _$loadingAtom =
      Atom(name: 'ApiCredentialsStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$bbApiCredentialsEntityAtom = Atom(
      name: 'ApiCredentialsStoreBase.bbApiCredentialsEntity', context: context);

  @override
  BBApiCredentialsEntity? get bbApiCredentialsEntity {
    _$bbApiCredentialsEntityAtom.reportRead();
    return super.bbApiCredentialsEntity;
  }

  @override
  set bbApiCredentialsEntity(BBApiCredentialsEntity? value) {
    _$bbApiCredentialsEntityAtom
        .reportWrite(value, super.bbApiCredentialsEntity, () {
      super.bbApiCredentialsEntity = value;
    });
  }

  late final _$sicoobApiCredentialsEntityAtom = Atom(
      name: 'ApiCredentialsStoreBase.sicoobApiCredentialsEntity',
      context: context);

  @override
  SicoobApiCredentialsEntity? get sicoobApiCredentialsEntity {
    _$sicoobApiCredentialsEntityAtom.reportRead();
    return super.sicoobApiCredentialsEntity;
  }

  @override
  set sicoobApiCredentialsEntity(SicoobApiCredentialsEntity? value) {
    _$sicoobApiCredentialsEntityAtom
        .reportWrite(value, super.sicoobApiCredentialsEntity, () {
      super.sicoobApiCredentialsEntity = value;
    });
  }

  late final _$loadDataAsyncAction =
      AsyncAction('ApiCredentialsStoreBase.loadData', context: context);

  @override
  Future<void> loadData() {
    return _$loadDataAsyncAction.run(() => super.loadData());
  }

  late final _$ApiCredentialsStoreBaseActionController =
      ActionController(name: 'ApiCredentialsStoreBase', context: context);

  @override
  void setBBApiCredentials(BBApiCredentialsEntity? credentials) {
    final _$actionInfo = _$ApiCredentialsStoreBaseActionController.startAction(
        name: 'ApiCredentialsStoreBase.setBBApiCredentials');
    try {
      return super.setBBApiCredentials(credentials);
    } finally {
      _$ApiCredentialsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSicoobApiCredentialsEntity(SicoobApiCredentialsEntity? credentials) {
    final _$actionInfo = _$ApiCredentialsStoreBaseActionController.startAction(
        name: 'ApiCredentialsStoreBase.setSicoobApiCredentialsEntity');
    try {
      return super.setSicoobApiCredentialsEntity(credentials);
    } finally {
      _$ApiCredentialsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$ApiCredentialsStoreBaseActionController.startAction(
        name: 'ApiCredentialsStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$ApiCredentialsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
bbApiCredentialsEntity: ${bbApiCredentialsEntity},
sicoobApiCredentialsEntity: ${sicoobApiCredentialsEntity},
hasApiCredentials: ${hasApiCredentials},
listAccounts: ${listAccounts}
    ''';
  }
}
