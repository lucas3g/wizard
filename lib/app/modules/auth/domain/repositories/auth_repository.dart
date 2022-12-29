import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';

abstract class IAuthRepository {
  AsyncResult<User, IAuthException> signInGoogle();
}
