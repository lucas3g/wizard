import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';

class Report extends Entity {
  Class reportClass;
  List<ReportStudent> students;
  List<Presence> presences;
  List<Homework> homeworks;

  Report({
    required super.id,
    required this.reportClass,
    required this.students,
    required this.presences,
    required this.homeworks,
  });

  @override
  Result<Report, String> validate([Object? object]) {
    return super.validate().flatMap(reportClass.validate).pure(this);
  }
}
