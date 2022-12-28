import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/text_vo.dart';

class StudentParents extends TextVO {
  const StudentParents(super.value);

  @override
  Result<StudentParents, String> validate([Object? object]) {
    return super.validate().flatMap(_localValidate);
  }

  Result<StudentParents, String> _localValidate(TextVO success) {
    if (value.split(' ').length < 2) {
      return '$runtimeType must contain first and last name'.toFailure();
    }
    return Success(this);
  }
}
