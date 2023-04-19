import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/home/controller/home_page_controller.dart';
import 'package:verify/app/modules/home/store/home_store.dart';
import 'package:verify/app/modules/home/view/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.instance<HomeStore>(HomeStore()),
        AutoBind.factory<HomePageController>(HomePageController.new),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, _) => const HomePage()),
      ];
}
