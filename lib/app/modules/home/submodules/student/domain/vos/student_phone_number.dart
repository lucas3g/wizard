import 'package:wizard/app/core_module/types/value_object.dart';

class StudentPhoneNumber implements ValueObject {
  final String _value;

  StudentPhoneNumber(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
