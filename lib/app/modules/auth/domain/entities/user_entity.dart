import 'package:wizard/app/modules/auth/domain/entities/address.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/birthday.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/confirm_password.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/cpf.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/email.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/name.dart';
import 'package:wizard/app/modules/auth/domain/vos/personal/password.dart';

class User {
  Name _name;
  CPF _cpf;
  BirthDay _birthDay;
  final Address _address;
  Email _email;
  Password _password;
  ConfirmPassword _confirmPassword;

  Name get name => _name;
  void setName(String value) => _name = Name(value);

  CPF get cpf => _cpf;
  void setCPF(String value) => _cpf = CPF(value);

  BirthDay get birthDay => _birthDay;
  void setBirthday(String value) => _birthDay = BirthDay(value);

  Address get address => _address;

  Email get email => _email;
  void setEmail(String value) => _email = Email(value);

  Password get password => _password;
  void setPassword(String value) => _password = Password(value);

  ConfirmPassword get confirmPassword => _confirmPassword;
  void setConfirmPassword(String value) =>
      _confirmPassword = ConfirmPassword(value);

  User({
    required name,
    required cpf,
    required birthDay,
    required Address address,
    required email,
    required password,
    required confirmPassword,
  })  : _name = Name(name),
        _cpf = CPF(cpf),
        _birthDay = BirthDay(birthDay),
        _address = Address(
          zipCode: address.zipCode.toString(),
          state: address.state.toString(),
          city: address.city.toString(),
          street: address.street.toString(),
          number: address.number.toString(),
          district: address.district.toString(),
        ),
        _email = Email(email),
        _password = Password(password),
        _confirmPassword = ConfirmPassword(confirmPassword);
}
