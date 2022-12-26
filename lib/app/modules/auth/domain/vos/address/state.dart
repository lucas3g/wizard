import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class State implements ValueObject {
  final String _value;

  State(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'State cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
