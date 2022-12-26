import 'package:wizard/app/core_module/types/value_object.dart';

class ConfirmPassword implements ValueObject {
  final String _value;

  ConfirmPassword(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Confirm password cannot be empty';
    }

    if (_value.length < 6) {
      return 'Confirm password must contain at least 6 characters';
    }

    return null;
  }

  @override
  String toString() => _value;
}
