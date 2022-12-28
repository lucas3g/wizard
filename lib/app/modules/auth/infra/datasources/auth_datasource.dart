import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';

abstract class IAuthDataSource {
  AsyncResult<GoogleSignInAccount, Exception> signInGoogle();
}
