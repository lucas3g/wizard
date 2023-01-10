import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/exceptions/report_exception.dart';

abstract class IReportRepository {
  Future<Result<bool, IReportException>> generatePDF(Report report);
}
