import 'package:brasil_fields/brasil_fields.dart';
import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class BirthDay implements ValueObject {
  final String _value;

  BirthDay(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Birthday cannot be empty';
    }

    if (!UtilData.validarData(_value)) {
      return 'Incorrect date of birth';
    }

    return null;
  }

  @override
  String toString() => _value;
}
