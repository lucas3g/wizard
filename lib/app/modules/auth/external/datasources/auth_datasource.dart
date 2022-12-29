import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/infra/datasources/auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  @override
  AsyncResult<GoogleSignInAccount, Exception> signInGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      final result = await googleSignIn.signIn();

      return Success(result!);
    } catch (e) {
      rethrow;
    }
  }
}
