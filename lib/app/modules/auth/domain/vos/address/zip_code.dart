import 'package:wizard/app/core_module/types/value_object.dart';

class ZipCode implements ValueObject {
  final String _value;

  ZipCode(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'ZipCode cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
