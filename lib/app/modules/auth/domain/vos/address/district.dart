import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class District implements ValueObject {
  final String _value;

  District(this._value);

  @override
  String? validator() {
    if (_value.isEmpty) {
      return 'District cannot be empty';
    }

    return null;
  }

  @override
  String toString() => _value;
}
