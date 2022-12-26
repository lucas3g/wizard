import 'package:wizard/app/core_module/types/value_object.dart';

class Number implements ValueObject {
  final String _value;

  Number(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Number cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
