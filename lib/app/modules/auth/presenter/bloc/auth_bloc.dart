// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/auth/domain/usecases/login_signin_google_usecase.dart';
import 'package:wizard/app/modules/auth/domain/usecases/logout_google_usecase.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ILoginSignInGoogleUseCase loginSignInGoogleUseCase;
  final ILogoutGoogleUseCase logoutGoogleUseCase;

  AuthBloc({
    required this.loginSignInGoogleUseCase,
    required this.logoutGoogleUseCase,
  }) : super(InitialAuth()) {
    on<SignInGoogleEvent>(_signinGoogle);
    on<LogOutGoogleEvent>(_logoutGoogle);
  }

  Future<void> _signinGoogle(SignInGoogleEvent event, emit) async {
    emit(LoadignAuth());

    final result = await loginSignInGoogleUseCase();

    result.fold(
      (success) => emit(SuccessAuth(user: success)),
      (failure) => emit(ErrorAuth(message: failure.toString())),
    );
  }

  Future<void> _logoutGoogle(LogOutGoogleEvent event, emit) async {
    emit(LoadignAuth());

    final result = await logoutGoogleUseCase();

    await Future.delayed(const Duration(milliseconds: 500));

    result.fold(
      (success) => emit(SuccessLogoutAuth()),
      (failure) => emit(ErrorAuth(message: failure.toString())),
    );
  }
}
