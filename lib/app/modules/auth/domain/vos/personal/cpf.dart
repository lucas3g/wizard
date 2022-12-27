import 'package:brasil_fields/brasil_fields.dart';
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class CPF implements ValueObject {
  final String _value;
  String get value => _value;

  CPF(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'CPF cannot be empty'.toFailure();
    }

    if (!CPFValidator.isValid(_value)) {
      return 'CPF invalid!'.toFailure();
    }

    return Success.unit();
  }
}
