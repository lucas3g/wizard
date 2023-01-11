import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entites/presence.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_obs.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

class Report extends Entity {
  Class reportClass;
  ReportObs _obs;
  List<ReportStudent> students;
  List<Presence> presences;
  List<Homework> homeworks;
  List<Review> reviews;

  ReportObs get obs => _obs;
  void setObs(String value) => _obs = ReportObs(value);

  Report({
    required super.id,
    required this.reportClass,
    required obs,
    required this.students,
    required this.presences,
    required this.homeworks,
    required this.reviews,
  }) : _obs = ReportObs(obs);

  @override
  Result<Report, String> validate([Object? object]) {
    return super.validate().flatMap(reportClass.validate).pure(this);
  }
}
