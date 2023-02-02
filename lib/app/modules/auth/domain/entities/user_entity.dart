import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity_account_google.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/photoUrl.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/email.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/name.dart';

class User extends EntityAccountGoogle {
  Name _name;
  Email _email;
  PhotoURL _photoURL;

  Name get name => _name;
  void setName(String value) => _name = Name(value);

  Email get email => _email;
  void setEmail(String value) => _email = Email(value);

  PhotoURL get photoURL => _photoURL;
  void setPhotoURL(String value) => _photoURL = PhotoURL(value);

  User({
    required super.id,
    required name,
    required email,
    required photoURL,
  })  : _name = Name(name),
        _email = Email(email),
        _photoURL = PhotoURL(photoURL);

  @override
  Result<User, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(name.validate)
        .flatMap(email.validate)
        .flatMap(photoURL.validate)
        .pure(this);
  }
}
