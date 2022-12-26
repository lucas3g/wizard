import 'package:brasil_fields/brasil_fields.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class CPF implements ValueObject {
  final String _value;

  CPF(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'CPF cannot be empty';
    }

    if (!CPFValidator.isValid(_value)) {
      return 'CPF invalid!';
    }

    return null;
  }

  @override
  String toString() => _value;
}
