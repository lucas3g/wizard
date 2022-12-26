import 'package:wizard/app/core_module/types/value_object.dart';

class Street implements ValueObject {
  final String _value;

  Street(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Street cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
