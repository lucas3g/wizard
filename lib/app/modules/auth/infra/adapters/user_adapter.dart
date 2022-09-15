import 'package:wizard/app/modules/auth/domain/entities/address.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';

class UserAdapter {
  static User empty() {
    return User(
      name: '',
      cpf: '',
      birthDay: '',
      address: Address.empty(),
      email: '',
      password: '',
      confirmPassword: '',
    );
  }
}
