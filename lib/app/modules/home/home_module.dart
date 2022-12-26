import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/presenter/home_page.dart';
import 'package:wizard/app/modules/home/submodules/student/student_module.dart';

class HomeModule extends Module {
  @override
  final List<Module> imports = [
    StudentModule(),
  ];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const HomePage()),
    ),
    ModuleRoute('/student', module: StudentModule()),
  ];
}
