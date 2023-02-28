import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/entities/presence.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_date_end.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_date_start.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_obs.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/vos/report_student.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/entities/review.dart';

class Report extends Entity {
  Class reportClass;
  ReportObs _obs;
  ReportDateStart _reportDateStart;
  ReportDateEnd _reportDateEnd;
  List<ReportStudent> students;
  List<Presence> presences;
  List<Homework> homeworks;
  List<Review> reviews;

  ReportObs get obs => _obs;
  void setObs(String value) => _obs = ReportObs(value);

  ReportDateStart get dateStart => _reportDateStart;
  void setDateStart(String value) => _reportDateStart = ReportDateStart(value);

  ReportDateEnd get dateEnd => _reportDateEnd;
  void setDateEnd(String value) => _reportDateEnd = ReportDateEnd(value);

  Report({
    required super.id,
    required this.reportClass,
    required obs,
    required this.students,
    required this.presences,
    required this.homeworks,
    required this.reviews,
    required reportDateStart,
    required reportDateEnd,
  })  : _obs = ReportObs(obs),
        _reportDateStart = ReportDateStart(reportDateStart),
        _reportDateEnd = ReportDateEnd(reportDateEnd);

  @override
  Result<Report, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(reportClass.validate)
        .flatMap(dateStart.validate)
        .flatMap(dateEnd.validate)
        .pure(this);
  }
}
