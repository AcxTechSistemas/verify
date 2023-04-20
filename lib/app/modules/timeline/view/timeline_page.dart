import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/modules/timeline/controller/timeline_controller.dart';
import 'package:verify/app/modules/timeline/store/timeline_store.dart';
import 'package:verify/app/modules/timeline/view/widgets/date_carrousel_widget.dart';
import 'package:verify/app/shared/widgets/bb_pix_list_view_builder_widget.dart';
import 'package:verify/app/shared/widgets/custom_navigation_bar.dart';
import 'package:verify/app/shared/widgets/empty_account_widget.dart';
import 'package:verify/app/shared/widgets/sicoob_pix_list_view_builder.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  final controller = Modular.get<TimelineController>();
  final store = Modular.get<TimelineStore>();
  final apiStore = Modular.get<ApiCredentialsStore>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Observer(
        builder: (context) {
          return Column(
            children: [
              DateCarrouselWidget(
                controller: controller.scrollController,
                onDateSelected: (date) {
                  setState(() {
                    controller.onDateSelected(date);
                  });
                },
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: colorScheme.onInverseSurface,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _TimelineAccountButton(
                      onTap: () => controller.selectAccout(0),
                      title: 'Sicoob',
                      selected: store.selectedSicoob,
                    ),
                    const SizedBox(width: 16),
                    _TimelineAccountButton(
                      onTap: () => controller.selectAccout(1),
                      title: 'Banco do Brasil',
                      selected: store.selectedBB,
                    ),
                  ],
                ),
              ),
              Builder(
                builder: (context) {
                  if (apiStore.hasApiCredentials) {
                    if (apiStore.hasBBApiCredentials) {
                      if (store.selectedBB) {
                        return Flexible(
                          child: BBPixListViewBuilder(
                            future: controller.fetchBBPixTransactions(
                              apiStore.bbApiCredentialsEntity!,
                              store.selectedDate,
                            ),
                          ),
                        );
                      }
                    }
                    if (apiStore.hasSicoobApiCredentials) {
                      if (store.selectedSicoob) {
                        return Flexible(
                          child: SicoobPixListViewBuilder(
                            future: controller.fetchSicoobPixTransactions(
                              apiStore.sicoobApiCredentialsEntity!,
                              store.selectedDate,
                            ),
                          ),
                        );
                      }
                    }
                  }
                  return const Flexible(
                    child: EmptyAccountWidget(),
                  );
                },
              ),
            ],
          );
        },
      ),
      floatingActionButton: Observer(builder: (context) {
        return Visibility(
          visible: store.showTodayFab,
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.today),
            label: const Text('Hoje'),
            onPressed: () {
              setState(() {
                controller.goToTodayDate();
              });
            },
          ),
        );
      }),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _TimelineAccountButton extends StatelessWidget {
  final String title;
  final bool selected;
  final void Function() onTap;

  const _TimelineAccountButton({
    required this.title,
    required this.onTap,
    required this.selected,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            border: selected
                ? null
                : Border.all(
                    color: colorScheme.secondaryContainer,
                    width: 1.5,
                  ),
            borderRadius: BorderRadius.circular(8),
            color: selected ? colorScheme.secondaryContainer : null,
          ),
          child: Text(
            title,
            style: textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}
