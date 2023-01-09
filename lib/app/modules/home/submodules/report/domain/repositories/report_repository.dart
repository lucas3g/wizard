import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/exceptions/report_exception.dart';

abstract class IReportRepository {
  AsyncResult<Report, IReportException> generatePDF(Report report);
}
