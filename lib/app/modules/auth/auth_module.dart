import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/domain/usecases/login_signin_google_usecase.dart';
import 'package:wizard/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:wizard/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/presenter/auth_page.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';

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
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IAuthDataSource>((i) => AuthDataSource()),

    //REPOSITORIES
    Bind.factory<IAuthRepository>(
      (i) => AuthRepository(dataSource: i()),
    ),

    //USECASES
    Bind.factory<ILoginSignInGoogleUseCase>(
      (i) => LoginSignInGoogleUseCase(repository: i()),
    ),

    BlocBind.factory<AuthBloc>(
      (i) => AuthBloc(useCase: i()),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => AuthPage(authBloc: Modular.get<AuthBloc>())),
    ),
  ];
}
