import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/auth/submodules/register/presenter/register_page.dart';

class RegisterModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => const RegisterPage()),
    ),
  ];
}
