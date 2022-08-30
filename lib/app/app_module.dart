import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/splash/splash_module.dart';

class AppModule extends Module {
  @override
  final List<Module> imports = [
    SplashModule(),
  ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
  ];
}
