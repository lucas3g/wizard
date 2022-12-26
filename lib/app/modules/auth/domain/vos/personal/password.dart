import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class Password implements ValueObject {
  final String _value;

  Password(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Password cannot be empty';
    }

    if (_value.length < 6) {
      return 'Password must contain at least 6 characters';
    }

    return null;
  }

  @override
  String toString() => _value;
}
