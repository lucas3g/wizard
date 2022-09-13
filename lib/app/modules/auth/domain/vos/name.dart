import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class Name implements ValueObject {
  final String _value;

  Name(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'Name cannot be empty';
    }

    return null;
  }
}
