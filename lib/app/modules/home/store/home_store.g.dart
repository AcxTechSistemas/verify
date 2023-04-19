// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  Computed<bool>? _$firstAccountSelectedComputed;

  @override
  bool get firstAccountSelected => (_$firstAccountSelectedComputed ??=
          Computed<bool>(() => super.firstAccountSelected,
              name: 'HomeStoreBase.firstAccountSelected'))
      .value;
  Computed<bool>? _$secondAccountSelectedComputed;

  @override
  bool get secondAccountSelected => (_$secondAccountSelectedComputed ??=
          Computed<bool>(() => super.secondAccountSelected,
              name: 'HomeStoreBase.secondAccountSelected'))
      .value;

  late final _$selectedAccountCardAtom =
      Atom(name: 'HomeStoreBase.selectedAccountCard', context: context);

  @override
  int get selectedAccountCard {
    _$selectedAccountCardAtom.reportRead();
    return super.selectedAccountCard;
  }

  @override
  set selectedAccountCard(int value) {
    _$selectedAccountCardAtom.reportWrite(value, super.selectedAccountCard, () {
      super.selectedAccountCard = value;
    });
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  dynamic setSelectedAccountCard(int selectedCard) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setSelectedAccountCard');
    try {
      return super.setSelectedAccountCard(selectedCard);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedAccountCard: ${selectedAccountCard},
firstAccountSelected: ${firstAccountSelected},
secondAccountSelected: ${secondAccountSelected}
    ''';
  }
}
