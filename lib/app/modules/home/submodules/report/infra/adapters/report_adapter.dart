import 'package:uuid/uuid.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/adapters/class_adapter.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';

class ReportAdapter {
  static Report empty() {
    return Report(
      id: IdVO(const Uuid().v1()),
      obs: '',
      reportClass: ClassAdapter.empty(),
      students: [],
      presences: [],
      homeworks: [],
      reviews: [],
    );
  }
}
