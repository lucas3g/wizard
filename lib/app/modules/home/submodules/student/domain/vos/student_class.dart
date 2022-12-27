import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class StudentClass implements ValueObject {
  final String _value;
  String get value => _value;

  StudentClass(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'Class cannot be empty'.toFailure();
    }

    return Success.unit();
  }
}
