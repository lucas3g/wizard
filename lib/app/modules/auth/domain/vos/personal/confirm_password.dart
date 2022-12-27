import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class ConfirmPassword implements ValueObject {
  final String _value;
  String get value => _value;

  ConfirmPassword(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'Confirm password cannot be empty'.toFailure();
    }

    if (_value.length < 6) {
      return 'Confirm password must contain at least 6 characters'.toFailure();
    }

    return Success.unit();
  }
}
