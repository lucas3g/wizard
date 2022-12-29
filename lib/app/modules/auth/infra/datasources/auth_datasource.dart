import 'package:google_sign_in/google_sign_in.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/auth/domain/exceptions/auth_exception.dart';

abstract class IAuthDataSource {
  AsyncResult<GoogleSignInAccount, IAuthException> signInGoogle();
}
