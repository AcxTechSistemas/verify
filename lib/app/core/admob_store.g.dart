// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admob_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AdMobStore on AdMobStoreBase, Store {
  Computed<bool>? _$hasBannerAdComputed;

  @override
  bool get hasBannerAd =>
      (_$hasBannerAdComputed ??= Computed<bool>(() => super.hasBannerAd,
              name: 'AdMobStoreBase.hasBannerAd'))
          .value;
  Computed<String>? _$bannerAdUnitIdComputed;

  @override
  String get bannerAdUnitId =>
      (_$bannerAdUnitIdComputed ??= Computed<String>(() => super.bannerAdUnitId,
              name: 'AdMobStoreBase.bannerAdUnitId'))
          .value;
  Computed<String>? _$nativeAdUnitIdComputed;

  @override
  String get nativeAdUnitId =>
      (_$nativeAdUnitIdComputed ??= Computed<String>(() => super.nativeAdUnitId,
              name: 'AdMobStoreBase.nativeAdUnitId'))
          .value;

  late final _$bannerAdAtom =
      Atom(name: 'AdMobStoreBase.bannerAd', context: context);

  @override
  BannerAd? get bannerAd {
    _$bannerAdAtom.reportRead();
    return super.bannerAd;
  }

  @override
  set bannerAd(BannerAd? value) {
    _$bannerAdAtom.reportWrite(value, super.bannerAd, () {
      super.bannerAd = value;
    });
  }

  late final _$loadBannerAdAsyncAction =
      AsyncAction('AdMobStoreBase.loadBannerAd', context: context);

  @override
  Future<void> loadBannerAd() {
    return _$loadBannerAdAsyncAction.run(() => super.loadBannerAd());
  }

  late final _$AdMobStoreBaseActionController =
      ActionController(name: 'AdMobStoreBase', context: context);

  @override
  Future<InitializationStatus> initAdMob() {
    final _$actionInfo = _$AdMobStoreBaseActionController.startAction(
        name: 'AdMobStoreBase.initAdMob');
    try {
      return super.initAdMob();
    } finally {
      _$AdMobStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo = _$AdMobStoreBaseActionController.startAction(
        name: 'AdMobStoreBase.dispose');
    try {
      return super.dispose();
    } finally {
      _$AdMobStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
bannerAd: ${bannerAd},
hasBannerAd: ${hasBannerAd},
bannerAdUnitId: ${bannerAdUnitId},
nativeAdUnitId: ${nativeAdUnitId}
    ''';
  }
}
