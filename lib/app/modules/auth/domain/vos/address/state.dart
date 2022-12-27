import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/value_object.dart';

class State implements ValueObject {
  final String _value;
  String get value => _value;

  State(this._value);

  @override
  Result<Unit, String> validate([Object? object]) {
    if (_value.isEmpty) {
      return 'State cannot be empty'.toFailure();
    }

    return Success.unit();
  }
}
