import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/shared/themes/theme.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = Modular.get<AppStore>();
    Modular.setInitialRoute('/auth/login');

    return FutureBuilder(
        future: appStore.loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const CircularProgressIndicator();
          }
          return Observer(
            builder: (context) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                themeMode: appStore.themeMode.value,
                theme: lightTheme,
                darkTheme: darkTheme,
                routerDelegate: Modular.routerDelegate,
                routeInformationParser: Modular.routeInformationParser,
              );
            },
          );
        });
  }
}
