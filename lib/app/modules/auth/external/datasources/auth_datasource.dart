// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  final GoogleSignIn googleSignIn;
  final ILocalStorage localStorage;

  AuthDataSource({
    required this.googleSignIn,
    required this.localStorage,
  });
  @override
  AsyncResult<GoogleSignInAccount, IAuthException> signInGoogle() async {
    try {
      final result = await googleSignIn.signIn();

      return Success(result!);
    } catch (e) {
      return AuthException(message: e.toString()).toFailure();
    }
  }

  @override
  AsyncResult<bool, IAuthException> logoutGoogle() async {
    try {
      await googleSignIn.signOut();

      await localStorage.removeData('user');

      return const Success(true);
    } catch (e) {
      return AuthException(message: e.toString()).toFailure();
    }
  }
}
