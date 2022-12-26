import 'package:wizard/app/core_module/types/value_object.dart';

class StudentName implements ValueObject {
  final String _value;

  StudentName(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Name cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
