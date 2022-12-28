import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/value_object.dart';

class TextVO extends ValueObject<String> {
  const TextVO(super.value);

  @override
  Result<TextVO, String> validate([Object? object]) {
    if (value.isEmpty) {
      return '$runtimeType cannot be empty'.toFailure();
    }
    return Success(this);
  }
}
