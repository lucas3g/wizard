import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/domain/repositories/auth_repository.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository({required this.dataSource});

  @override
  AsyncResult<User, Exception> signInGoogle() {
    return dataSource.signInGoogle().mapError(Exception.new).flatMap(
        (success) => UserAdapter.fromGoogleAccount(success).toSuccess());
  }
}
