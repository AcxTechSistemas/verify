import 'dart:io';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:verify/app/shared/error_registrator/register_log.dart';
import 'package:verify/app/shared/error_registrator/send_logs_to_web.dart';
part 'admob_store.g.dart';

class AdMobStore = AdMobStoreBase with _$AdMobStore;

abstract class AdMobStoreBase with Store {
  @observable
  BannerAd? bannerAd;

  @computed
  bool get hasBannerAd => bannerAd != null;

  @computed
  String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3590770249573148/9929613646';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @computed
  String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3590770249573148/7185683197';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  @action
  Future<InitializationStatus> initAdMob() {
    return MobileAds.instance.initialize();
  }

  @action
  Future<void> loadBannerAd() async {
    await BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          bannerAd = ad as BannerAd;
        },
        onAdFailedToLoad: (ad, error) async {
          final registerLog = Modular.get<RegisterLog>();
          final sendLogsToWeb = Modular.get<SendLogsToWeb>();
          final message =
              'Ad load failed (code=${error.code} message=${error.message})';
          registerLog(message);
          await sendLogsToWeb(message);
        },
      ),
    ).load();
  }

  @action
  void dispose() {
    bannerAd?.dispose();
    bannerAd = null;
  }
}
