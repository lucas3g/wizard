// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ILoginSignInGoogleUseCase {
  AsyncResult<User, IAuthException> call();
}

class LoginSignInGoogleUseCase implements ILoginSignInGoogleUseCase {
  final IAuthRepository repository;

  LoginSignInGoogleUseCase({required this.repository});

  @override
  AsyncResult<User, IAuthException> call() {
    return repository.signInGoogle();
  }
}
