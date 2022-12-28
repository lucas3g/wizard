import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/value_object.dart';

class IdVO extends ValueObject<String> {
  const IdVO(super.value);

  @override
  Result<IdVO, String> validate([Object? object]) {
    if (value.isEmpty) {
      return '$runtimeType cannot be empty'.toFailure();
    }
    return Success(this);
  }
}
