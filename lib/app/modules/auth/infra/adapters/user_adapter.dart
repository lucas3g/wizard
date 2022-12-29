import 'dart:convert';

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

  static String toJson(User user) {
    return jsonEncode({
      "id": user.id.value,
      "name": user.name.value,
      "email": user.email.value,
      "photoURL": user.photoURL.value,
    });
  }

  static User fromMap(dynamic map) {
    return User(
      id: IdVO(map['id']),
      name: map['name'],
      email: map['email'],
      photoURL: map['photoURL'],
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
