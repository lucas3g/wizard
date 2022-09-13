import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';
import 'package:string_validator/string_validator.dart' as string_validator;

class Email implements ValueObject {
  final String _value;

  Email(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Email cannot be empty';
    }

    if (!string_validator.isEmail(_value)) {
      return 'Email invalid!';
    }
    return null;
  }

  @override
  String toString() => _value;
}
