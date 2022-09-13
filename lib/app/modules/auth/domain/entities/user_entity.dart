import 'package:wizard/app/modules/auth/domain/entities/address.dart';
import 'package:wizard/app/modules/auth/domain/vos/cpf.dart';
import 'package:wizard/app/modules/auth/domain/vos/email.dart';
import 'package:wizard/app/modules/auth/domain/vos/name.dart';
import 'package:wizard/app/modules/auth/domain/vos/password.dart';

class User {
  Name _name;
  CPF _cpf;
  DateTime birthDay;
  Address address;
  Email _email;
  Password _password;
  Password _confirmPassword;

  Name get name => _name;
  void setName(String value) => _name = Name(value);

  CPF get cpf => _cpf;
  void setCPF(String value) => _cpf = CPF(value);

  Email get email => _email;
  void setEmail(String value) => _email = Email(value);

  Password get password => _password;
  void setPassword(String value) => _password = Password(value, null);

  Password get confirmPassword => _confirmPassword;
  void setConfirmPassword(String value) =>
      _confirmPassword = Password(null, value);

  User({
    required String name,
    required String cpf,
    required this.birthDay,
    required this.address,
    required String email,
    required String password,
    required String confirmPassword,
  })  : _name = Name(name),
        _cpf = CPF(cpf),
        _email = Email(email),
        _password = Password(password, null),
        _confirmPassword = Password(null, confirmPassword);
}
