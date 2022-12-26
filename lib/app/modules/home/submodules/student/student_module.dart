import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/student_page.dart';

class StudentModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const StudentPage()),
    ),
  ];
}
