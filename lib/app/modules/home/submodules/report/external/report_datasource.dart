// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/core_module/services/pdf/pdf_interface.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/exceptions/report_exception.dart';
import 'package:wizard/app/modules/home/submodules/report/infra/datasources/report_datasource.dart';

class ReportDatasource implements IReportDatasource {
  final IPDF pdf;

  ReportDatasource({
    required this.pdf,
  });

  @override
  AsyncResult<Report, IReportException> generatePDF(Report report) async {
    try {
      await pdf.generatePDF(report: report);

      return report.toSuccess();
    } catch (e) {
      return ReportException(message: e.toString()).toFailure();
    }
  }
}
