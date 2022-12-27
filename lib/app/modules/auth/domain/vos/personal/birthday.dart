import 'package:brasil_fields/brasil_fields.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class BirthDay implements ValueObject {
  final String _value;
  String get value => _value;

  BirthDay(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'Birthday cannot be empty'.toFailure();
    }

    if (!UtilData.validarData(_value)) {
      return 'Incorrect date of birth'.toFailure();
    }

    return Success.unit();
  }
}
