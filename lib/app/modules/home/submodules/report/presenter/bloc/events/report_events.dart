// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/report/domain/entities/report.dart';

abstract class ReportEvents {}

class GenerateReportPDFEvent extends ReportEvents {
  final Report report;

  GenerateReportPDFEvent({
    required this.report,
  });
}
