import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';

abstract class IReportDatasource {
  Future<bool> generatePDF(Report report);
}
