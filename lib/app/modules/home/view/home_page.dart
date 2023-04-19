import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/home/controller/home_page_controller.dart';
import 'package:verify/app/modules/home/store/home_store.dart';
import 'package:verify/app/modules/home/view/widgets/account_card_widget.dart';
import 'package:verify/app/shared/widgets/bb_pix_list_view_builder_widget.dart';
import 'package:verify/app/shared/widgets/custom_navigation_bar.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';
import 'package:verify/app/shared/widgets/empty_account_widget.dart';
import 'package:verify/app/shared/widgets/menu_title_widget.dart';
import 'package:verify/app/shared/widgets/sicoob_pix_list_view_builder.dart';
import 'widgets/selected_page_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeStore = Modular.get<HomeStore>();
  final apiStore = Modular.get<ApiCredentialsStore>();
  final controller = Modular.get<HomePageController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Scaffold(
      body: Observer(builder: (context) {
        return Column(
          children: [
            Container(
              color: colorScheme.onInverseSurface,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/logo.svg',
                        height: 20,
                        alignment: Alignment.centerLeft,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        controller.dayTimeMessage,
                        style: textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const MenuTitleWidget(
                        title: 'Contas',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 60,
              child: Container(
                color: colorScheme.onInverseSurface,
                child: PageView.builder(
                  onPageChanged: controller.onAccountChanged,
                  controller: controller.pageController,
                  itemCount: apiStore.listAccounts.length,
                  itemBuilder: (context, index) {
                    final account = apiStore.listAccounts[index];
                    return AccountCardWidget(
                      setFavorite: () async {
                        final isSicoob = account.containsValue('sicoob');
                        final isBB = account.containsValue('bancoDoBrasil');
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
                ),
              ),
            ),
            SelectedPageWidget(
              selectedPage: homeStore.selectedAccountCard,
            ),
            Flexible(
              flex: 100,
              child: Builder(
                builder: (_) {
                  if (apiStore.hasApiCredentials) {
                    //See BB Transactions if Selected
                    if (apiStore.hasBBApiCredentials) {
                      if (apiStore.firstIsBB &&
                              homeStore.firstAccountSelected ||
                          !apiStore.firstIsBB &&
                              homeStore.secondAccountSelected) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: BBPixListViewBuilder(
                            future: controller.fetchBBPixTransactions(
                              apiStore.bbApiCredentialsEntity!,
                            ),
                          ),
                        );
                      }
                    }
                    //See Sicoob Transactions if Selected
                    if (apiStore.hasSicoobApiCredentials) {
                      if (apiStore.firstIsSicoob &&
                              homeStore.firstAccountSelected ||
                          !apiStore.firstIsSicoob &&
                              homeStore.secondAccountSelected) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            setState(() {});
                          },
                          child: SicoobPixListViewBuilder(
                            future: controller.fetchSicoobPixTransactions(
                              apiStore.sicoobApiCredentialsEntity!,
                            ),
                          ),
                        );
                      }
                    }
                  }
                  return const EmptyAccountWidget();
                },
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: const CustomNavigationBar(),
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
