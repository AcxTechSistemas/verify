import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:verify/app/core/admob_store.dart';
import 'package:verify/app/core/api_credentials_store.dart';
import 'package:verify/app/core/app_store.dart';
import 'package:verify/app/core/auth_store.dart';

import 'package:verify/app/shared/themes/theme.dart';
import 'package:verify/app/splash_screen_widget.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final appStore = Modular.get<AppStore>();
  final authStore = Modular.get<AuthStore>();
  final apiCredentialsStore = Modular.get<ApiCredentialsStore>();
  final adMobStore = Modular.get<AdMobStore>();

  bool intialized = false;

  Future<void> loadData() async {
    Intl.defaultLocale = 'pt_BR';
    await initializeDateFormatting();
    await appStore.loadData();
    await authStore.loadData();
    await apiCredentialsStore.loadData();
    await adMobStore.initAdMob();

    if (mounted) {
      setState(() {
        intialized = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return !intialized
        ? const SplashScreen()
        : Observer(
            builder: (context) {
              Modular.setInitialRoute(
                authStore.loggedUser == null ? '/auth/login' : '/home/',
              );
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
  }
}
