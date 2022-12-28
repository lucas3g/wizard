import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  AsyncResult<User, Exception> signInGoogle();
}
