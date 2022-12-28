import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/text_vo.dart';

class StudentName extends TextVO {
  const StudentName(super.value);

  @override
  Result<StudentName, String> validate([Object? object]) {
    return super.validate().flatMap(_localValidate);
  }

  Result<StudentName, String> _localValidate(TextVO success) {
    if (value.split(' ').length < 2) {
      return '$runtimeType must contain first and last name'.toFailure();
    }
    return Success(this);
  }
}
