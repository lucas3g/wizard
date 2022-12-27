import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';
import 'package:string_validator/string_validator.dart' as string_validator;

class Email implements ValueObject {
  final String _value;
  String get value => _value;

  Email(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'Email cannot be empty'.toFailure();
    }

    if (!string_validator.isEmail(_value)) {
      return 'Email invalid!'.toFailure();
    }
    return Success.unit();
  }
}
