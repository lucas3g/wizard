// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/auth/domain/usecases/login_signin_google_usecase.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/events/auth_events.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/states/auth_states.dart';

class AuthBloc extends Bloc<AuthEvents, AuthStates> {
  final ILoginSignInGoogleUseCase useCase;

  AuthBloc({
    required this.useCase,
  }) : super(InitialAuth()) {
    on<SignInGoogleEvent>(_signinGoogle);
  }

  Future<void> _signinGoogle(SignInGoogleEvent event, emit) async {
    emit(LoadignAuth());

    final result = await useCase();

    result.fold(
      (success) => emit(SuccessAuth(user: success)),
      (failure) => emit(ErrorAuth(message: failure.toString())),
    );
  }
}
