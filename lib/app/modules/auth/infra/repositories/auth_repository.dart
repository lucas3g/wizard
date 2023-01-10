import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  Future<Result<User, IAuthException>> signInGoogle() async {
    try {
      final result = await dataSource.signInGoogle();

      final user = UserAdapter.fromGoogleAccount(result);

      return user.toSuccess();
    } on IAuthException catch (e) {
      return AuthException(message: e.message).toFailure();
    } catch (e) {
      return AuthException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<bool, IAuthException> logoutGoogle() async {
    try {
      final result = await dataSource.logoutGoogle();

      return result.toSuccess();
    } on IAuthException catch (e) {
      return AuthException(message: e.message).toFailure();
    } catch (e) {
      return AuthException(message: e.toString()).toFailure();
    }
  }
}
