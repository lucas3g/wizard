// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';

import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/exceptions/report_exception.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/repositories/report_repository.dart';

abstract class IGenerateFilePDFUseCase {
  AsyncResult<bool, IReportException> call(Report report);
}

class GenerateFilePDFUseCase implements IGenerateFilePDFUseCase {
  final IReportRepository repository;

  GenerateFilePDFUseCase({
    required this.repository,
  });

  @override
  AsyncResult<bool, IReportException> call(Report report) {
    return report
        .validate()
        .mapError<IReportException>((error) => ReportException(message: error))
        .toAsyncResult()
        .flatMap(repository.generatePDF);
  }
}
