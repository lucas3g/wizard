import 'package:wizard/app/core_module/types/value_object.dart';

class City implements ValueObject {
  final String _value;

  City(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'City cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
