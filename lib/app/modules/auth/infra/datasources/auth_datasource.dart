import 'package:google_sign_in/google_sign_in.dart';

abstract class IAuthDataSource {
  Future<GoogleSignInAccount> signInGoogle();
  Future<bool> logoutGoogle();
}
