// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:google_sign_in/google_sign_in.dart';

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
  Future<GoogleSignInAccount> signInGoogle() async {
    final result = await googleSignIn.signIn();

    if (result == null) {
      throw const AuthException(message: 'Error when trying to login ');
    }

    return result;
  }

  @override
  Future<bool> logoutGoogle() async {
    await googleSignIn.signOut();

    await localStorage.removeData('user');

    return true;
  }
}
