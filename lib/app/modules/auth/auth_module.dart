import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/auth/presenter/login/controller/login_controller.dart';
import 'package:verify/app/modules/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/modules/auth/presenter/login/view/login_page.dart';
import 'package:verify/app/modules/auth/presenter/recover/controller/recover_account_page_controller.dart';
import 'package:verify/app/modules/auth/presenter/recover/store/recover_account_store.dart';
import 'package:verify/app/modules/auth/presenter/recover/view/recover_account_page.dart';
import 'package:verify/app/modules/auth/presenter/register/controller/register_controller.dart';
import 'package:verify/app/modules/auth/presenter/register/store/register_store.dart';
import 'package:verify/app/modules/auth/presenter/register/view/register_page.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.instance<LoginStore>(LoginStore()),
        AutoBind.instance<RegisterStore>(RegisterStore()),
        AutoBind.instance<RecoverAccountPageStore>(RecoverAccountPageStore()),
        AutoBind.factory<LoginController>(LoginController.new),
        AutoBind.factory<RegisterController>(RegisterController.new),
        AutoBind.factory<RecoverAccountPageController>(
          RecoverAccountPageController.new,
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/login', child: (context, _) => const LoginPage()),
        ChildRoute('/register', child: (context, _) => const RegisterPage()),
        ChildRoute(
          '/recover',
          child: (context, _) => const RecoverAccountPage(),
        ),
      ];
}
