// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timeline_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TimelineStore on TimelineStoreBase, Store {
  Computed<bool>? _$selectedSicoobComputed;

  @override
  bool get selectedSicoob =>
      (_$selectedSicoobComputed ??= Computed<bool>(() => super.selectedSicoob,
              name: 'TimelineStoreBase.selectedSicoob'))
          .value;
  Computed<bool>? _$selectedBBComputed;

  @override
  bool get selectedBB =>
      (_$selectedBBComputed ??= Computed<bool>(() => super.selectedBB,
              name: 'TimelineStoreBase.selectedBB'))
          .value;

  late final _$selectedAccountAtom =
      Atom(name: 'TimelineStoreBase.selectedAccount', context: context);

  @override
  int get selectedAccount {
    _$selectedAccountAtom.reportRead();
    return super.selectedAccount;
  }

  @override
  set selectedAccount(int value) {
    _$selectedAccountAtom.reportWrite(value, super.selectedAccount, () {
      super.selectedAccount = value;
    });
  }

  late final _$TimelineStoreBaseActionController =
      ActionController(name: 'TimelineStoreBase', context: context);

  @override
  dynamic setselectedAccount(int selected) {
    final _$actionInfo = _$TimelineStoreBaseActionController.startAction(
        name: 'TimelineStoreBase.setselectedAccount');
    try {
      return super.setselectedAccount(selected);
    } finally {
      _$TimelineStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAccount: ${selectedAccount},
selectedSicoob: ${selectedSicoob},
selectedBB: ${selectedBB}
    ''';
  }
}
