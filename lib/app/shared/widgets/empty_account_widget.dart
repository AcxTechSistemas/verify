import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:verify/app/core/admob_store.dart';

class EmptyAccountWidget extends StatefulWidget {
  const EmptyAccountWidget({super.key});

  @override
  State<EmptyAccountWidget> createState() => _EmptyAccountWidgetState();
}

class _EmptyAccountWidgetState extends State<EmptyAccountWidget> {
  final adMobStore = Modular.get<AdMobStore>();

  @override
  void initState() {
    super.initState();
    adMobStore.loadBannerAd();
  }

  @override
  void dispose() {
    adMobStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Configure sua conta para ter acesso aos nossos serviços',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium!.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Expanded(
                  child: Lottie.asset(
                    'assets/animations/emptyAccounts.json',
                  ),
                ),
              ],
            ),
          ),
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: adMobStore.bannerAd != null,
              child: Container(
                width: adMobStore.bannerAd?.size.width.toDouble(),
                height: 72.0,
                alignment: Alignment.center,
                child: adMobStore.hasBannerAd
                    ? AdWidget(ad: adMobStore.bannerAd!)
                    : null,
              ),
            );
          },
        ),
      ],
    );
  }
}
