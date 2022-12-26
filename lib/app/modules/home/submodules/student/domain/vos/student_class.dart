import 'package:wizard/app/core_module/types/value_object.dart';

class StudentClass implements ValueObject {
  final String _value;

  StudentClass(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Class cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
