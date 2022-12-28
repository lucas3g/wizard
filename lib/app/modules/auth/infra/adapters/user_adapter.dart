import 'package:google_sign_in/google_sign_in.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';

class UserAdapter {
  static User fromGoogleAccount(GoogleSignInAccount account) {
    return User(
      id: IdVO(account.id),
      name: account.displayName ?? '',
      email: account.email,
      photoURL: account.photoUrl ?? '',
    );
  }

  static User empty() {
    return User(
      id: const IdVO('1'),
      name: '',
      email: '',
      photoURL: '',
    );
  }
}
