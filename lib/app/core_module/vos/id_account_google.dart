import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/value_object.dart';

class IdAccountGoogleVO extends ValueObject<String> {
  const IdAccountGoogleVO(super.value);

  @override
  Result<IdAccountGoogleVO, String> validate([Object? object]) {
    if (value.isEmpty) {
      return '$runtimeType cannot be empty'.toFailure();
    }
    return Success(this);
  }
}
