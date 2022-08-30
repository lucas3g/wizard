import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/auth/presenter/auth_page.dart';
import 'package:wizard/app/modules/auth/submodules/register/register_module.dart';

ModuleRoute configuraModule(
  String name, {
  required Module module,
  TransitionType? transition,
  CustomTransition? customTransition,
  Duration? duration,
  List<RouteGuard> guards = const [],
}) {
  return ModuleRoute(
    name,
    transition: TransitionType.noTransition,
    module: module,
  );
}

class AuthModule extends Module {
  @override
  final List<Module> imports = [
    RegisterModule(),
  ];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const AuthPage()),
    ),
    configuraModule('/register', module: RegisterModule()),
  ];
}
