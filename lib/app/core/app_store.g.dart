// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  late final _$loadingAtom =
      Atom(name: 'AppStoreBase.loading', context: context);

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

  late final _$themeModeAtom =
      Atom(name: 'AppStoreBase.themeMode', context: context);

  @override
  Observable<ThemeMode> get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(Observable<ThemeMode> value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$currentDestinationAtom =
      Atom(name: 'AppStoreBase.currentDestination', context: context);

  @override
  Observable<int> get currentDestination {
    _$currentDestinationAtom.reportRead();
    return super.currentDestination;
  }

  @override
  set currentDestination(Observable<int> value) {
    _$currentDestinationAtom.reportWrite(value, super.currentDestination, () {
      super.currentDestination = value;
    });
  }

  late final _$AppStoreBaseActionController =
      ActionController(name: 'AppStoreBase', context: context);

  @override
  void setPreferredTheme(ThemeMode theme) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setPreferredTheme');
    try {
      return super.setPreferredTheme(theme);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCurrentDestination(int destination) {
    final _$actionInfo = _$AppStoreBaseActionController.startAction(
        name: 'AppStoreBase.setCurrentDestination');
    try {
      return super.setCurrentDestination(destination);
    } finally {
      _$AppStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
themeMode: ${themeMode},
currentDestination: ${currentDestination}
    ''';
  }
}
