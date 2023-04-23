import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/home/controller/home_page_controller.dart';
import 'package:verify/app/modules/home/view/widgets/account_card_widget.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';

class AccountCardPageView extends StatefulWidget {
  const AccountCardPageView({super.key});

  @override
  State<AccountCardPageView> createState() => _AccountCardPageViewState();
}

class _AccountCardPageViewState extends State<AccountCardPageView> {
  final apiStore = Modular.get<ApiCredentialsStore>();
  final controller = Modular.get<HomePageController>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          color: colorScheme.onInverseSurface,
          child: Observer(
            builder: (context) {
              return PageView.builder(
                onPageChanged: controller.onAccountChanged,
                controller: PageController(
                  viewportFraction: constraints.maxHeight * 0.0037,
                  initialPage: 0,
                ),
                itemCount: apiStore.listAccounts.length,
                itemBuilder: (context, index) {
                  final account = apiStore.listAccounts[index];
                  final isSicoob = account.containsValue('sicoob');
                  final isBB = account.containsValue('bancoDoBrasil');
                  return AccountCardWidget(
                    onTap: () {
                      if (isSicoob) {
                        controller.goToSicoobSettings();
                      }
                      if (isBB) {
                        controller.goToBBSettings();
                      }
                    },
                    setFavorite: () async {
                      if (isSicoob) {
                        await _setSicoobFavorite();
                      }
                      if (isBB) {
                        await _setBBFavorite();
                      }
                    },
                    imageAsset: account['imageAsset'],
                    hasCredentials: account['hasCredentials'],
                    isFavorite: account['isFavorite'],
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _setSicoobFavorite() async {
    await controller.setSicoobFavorite().then((errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: errorMessage,
            snackBarType: SnackBarType.error,
          ),
        );
      }
    });
  }

  Future<void> _setBBFavorite() async {
    await controller.setBBFavorite().then((errorMessage) {
      if (errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(
            message: errorMessage,
            snackBarType: SnackBarType.error,
          ),
        );
      }
    });
  }
}
