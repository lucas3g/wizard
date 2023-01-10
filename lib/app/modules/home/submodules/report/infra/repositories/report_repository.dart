// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/exceptions/report_exception.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/repositories/report_repository.dart';
import 'package:wizard/app/modules/home/submodules/report/infra/datasources/report_datasource.dart';

class ReportRepository implements IReportRepository {
  final IReportDatasource datasource;

  ReportRepository({
    required this.datasource,
  });

  @override
  Future<Result<bool, IReportException>> generatePDF(Report report) async {
    try {
      final result = await datasource.generatePDF(report);

      return result.toSuccess();
    } catch (e) {
      return ReportException(message: e.toString()).toFailure();
    }
  }
}
