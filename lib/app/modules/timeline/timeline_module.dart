import 'package:flutter_modular/flutter_modular.dart';
import 'package:verify/app/modules/timeline/controller/timeline_controller.dart';
import 'package:verify/app/modules/timeline/store/timeline_store.dart';
import 'package:verify/app/modules/timeline/view/timeline_page.dart';

class TimelineModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        AutoBind.instance<TimelineStore>(TimelineStore()),
        AutoBind.singleton<TimelineController>(TimelineController.new),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const TimelinePage()),
      ];
}
