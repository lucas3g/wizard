// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';

abstract class ILogoutGoogleUseCase {
  AsyncResult<bool, IAuthException> call();
}

class LogoutGoogleUseCase implements ILogoutGoogleUseCase {
  final IAuthRepository repository;

  LogoutGoogleUseCase({required this.repository});

  @override
  AsyncResult<bool, IAuthException> call() {
    return repository.logoutGoogle();
  }
}
