import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/value_object.dart';

class DoubleVO extends ValueObject<double> {
  const DoubleVO(super.value);

  @override
  Result<DoubleVO, String> validate([Object? object]) {
    if (value < 0) {
      return '$runtimeType cannot be less than zero'.toFailure();
    }
    return Success(this);
  }
}
