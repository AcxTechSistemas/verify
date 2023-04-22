import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/home/controller/home_page_controller.dart';
import 'package:verify/app/modules/home/store/home_store.dart';
import 'package:verify/app/modules/home/view/widgets/account_card_widget.dart';
import 'package:verify/app/shared/widgets/pix_list_view_builder_widget.dart';
import 'package:verify/app/shared/widgets/custom_navigation_bar.dart';
import 'package:verify/app/shared/widgets/custom_snack_bar.dart';
import 'package:verify/app/shared/widgets/empty_account_widget.dart';
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
  void initState() {
    super.initState();
    controller.refreshCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final viewportWidth = screenWidth * 0.8;
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.greetingDayMessage,
                                  style: textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: colorScheme.outline,
                                  ),
                                ),
                                Visibility(
                                  visible: controller.hasUserMessage,
                                  child: Text(
                                    controller.greetingUserMessage,
                                    style: textTheme.titleMedium!.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: colorScheme.outline,
                                      fontSize: 18,
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: SvgPicture.asset(
                              'assets/svg/logo.svg',
                              height: 20,
                              alignment: Alignment.centerLeft,
                              // ignore: deprecated_member_use
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
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
                  controller: PageController(
                    viewportFraction: viewportWidth / screenWidth,
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
                            setState(() {
                              controller.refreshCurrentDate();
                            });
                          },
                          child: PixListViewBuilder(
                            replacementTitle: 'Transações recentes',
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
                            setState(() {
                              controller.refreshCurrentDate();
                            });
                          },
                          child: PixListViewBuilder(
                            replacementTitle: 'Transações recentes',
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
