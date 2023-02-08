import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_present.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/vos/presence_student_id.dart';

class PresenceCheck extends Entity {
  PresenceStudentID _studentID;
  PresencePresent _presencePresent;

  PresenceStudentID get studentID => _studentID;
  void setStudentID(int value) => _studentID = PresenceStudentID(value);

  PresencePresent get presencePresent => _presencePresent;
  void setPresencePresent(String value) =>
      _presencePresent = PresencePresent(value);

  PresenceCheck({
    required super.id,
    required studentID,
    required presencePresent,
  })  : _studentID = PresenceStudentID(studentID),
        _presencePresent = PresencePresent(presencePresent);
}
