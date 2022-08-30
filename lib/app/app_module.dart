import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/core_module.dart';
import 'package:wizard/app/modules/auth/auth_module.dart';
import 'package:wizard/app/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
  ];
}
