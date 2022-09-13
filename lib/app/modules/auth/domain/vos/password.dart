import 'package:wizard/app/modules/auth/domain/vos/value_object.dart';

class Password implements ValueObject {
  final String? _password;
  final String? _confirmPassword;

  Password([this._password, this._confirmPassword]);

  @override
  String? validator() {
    if (_password != null) {
      if (_password!.isEmpty) {
        return 'Password cannot be empty';
      }
      if (_password!.length < 6) {
        return 'Password must contain at least 6 characters';
      }
    }

    if (_confirmPassword != null && _password != null) {
      if (_confirmPassword!.isEmpty) {
        return 'Confirm password cannot be empty';
      }
      if (_confirmPassword!.compareTo(_password!) != 0) {
        return 'Passwords do not match';
      }
    }

    return null;
  }

  String toStringPassword() => _password!;

  String toStringConfirmPassword() => _password!;
}
