import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class BirthDay implements ValueObject {
  final String _value;

  BirthDay(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Birthday cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
