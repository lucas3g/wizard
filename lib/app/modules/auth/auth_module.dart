import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/auth/presenter/auth_page.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';

class AuthModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => AuthPage(authBloc: Modular.get<AuthBloc>())),
    ),
  ];
}
