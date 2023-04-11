import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/features/auth/presenter/login/controller/login_controller.dart';
import 'package:verify/app/features/auth/presenter/login/store/login_store.dart';
import 'package:verify/app/features/auth/presenter/login/view/login_page.dart';

class AuthModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.instance<LoginStore>(LoginStore()),
        AutoBind.factory<LoginController>(LoginController.new),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/login', child: (context, _) => const LoginPage()),
      ];
}
