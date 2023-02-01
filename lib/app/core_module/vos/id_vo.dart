import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/value_object.dart';

class IdVO extends ValueObject<int> {
  const IdVO(super.value);

  @override
  Result<IdVO, String> validate([Object? object]) {
    if (value < 0) {
      return '$runtimeType cannot be empty'.toFailure();
    }
    return Success(this);
  }
}
