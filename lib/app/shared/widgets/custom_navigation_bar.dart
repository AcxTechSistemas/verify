import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/app_store.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = Modular.get<AppStore>();
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Observer(
      builder: (context) {
        final currentDestination = appStore.currentDestination.value;
        return NavigationBar(
          selectedIndex: currentDestination,
          onDestinationSelected: (selectedDestination) {
            appStore.setCurrentDestination(selectedDestination);
            if (currentDestination != selectedDestination) {
              switch (selectedDestination) {
                case 0:
                  Modular.to.pushReplacementNamed('/home/');
                  break;
                case 1:
                  Modular.to.pushReplacementNamed('/timeline/');
                  break;
                case 2:
                  Modular.to.pushReplacementNamed('/settings/');
                  break;
              }
            }
          },
          elevation: 0,
          height: 60,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          backgroundColor: colorScheme.onInverseSurface,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.timeline),
              label: 'Transações',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        );
      },
    );
  }
}
