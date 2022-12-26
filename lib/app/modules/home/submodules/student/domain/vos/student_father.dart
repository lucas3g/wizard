import 'package:wizard/app/core_module/types/value_object.dart';

class StudentFather implements ValueObject {
  final String _value;

  StudentFather(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Father cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
