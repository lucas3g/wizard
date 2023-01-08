import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/core_module/core_module.dart';
import 'package:wizard/app/modules/auth/auth_module.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/domain/usecases/login_signin_google_usecase.dart';
import 'package:wizard/app/modules/auth/domain/usecases/logout_google_usecase.dart';
import 'package:wizard/app/modules/auth/external/datasources/auth_datasource.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';
import 'package:wizard/app/modules/auth/infra/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/home/home_module.dart';
import 'package:wizard/app/modules/splash/splash_module.dart';

Bind<GoogleSignIn> _googleSign() {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  return Bind.factory<GoogleSignIn>((i) => googleSignIn);
}

class AppModule extends Module {
  @override
  final List<Module> imports = [
    CoreModule(),
    SplashModule(),
    AuthModule(),
    HomeModule(),
  ];

  @override
  final List<Bind> binds = [
    //GOOGLE
    _googleSign(),

    //DATASOURCES
    Bind.factory<IAuthDataSource>(
      (i) => AuthDataSource(
        googleSignIn: i(),
        localStorage: i(),
      ),
    ),

    //REPOSITORIES
    Bind.factory<IAuthRepository>(
      (i) => AuthRepository(dataSource: i()),
    ),

    //USECASES
    Bind.factory<ILoginSignInGoogleUseCase>(
      (i) => LoginSignInGoogleUseCase(repository: i()),
    ),
    Bind.factory<ILogoutGoogleUseCase>(
      (i) => LogoutGoogleUseCase(repository: i()),
    ),

    BlocBind.factory<AuthBloc>(
      (i) => AuthBloc(
        loginSignInGoogleUseCase: i(),
        logoutGoogleUseCase: i(),
      ),
    )
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: SplashModule()),
    ModuleRoute('/auth', module: AuthModule()),
    ModuleRoute('/home', module: HomeModule()),
  ];
}
