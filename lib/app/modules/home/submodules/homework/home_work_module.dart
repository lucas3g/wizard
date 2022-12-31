import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/home_work_page.dart';

class HomeWorkModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const HomeWorkPage()),
    ),
  ];
}
