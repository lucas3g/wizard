abstract class ReportStates {}

class InitialReport extends ReportStates {}

class LoadingReport extends ReportStates {}

class SuccessGenerateReport extends ReportStates {}

class ErrorGenerateReport extends ReportStates {
  final String message;

  ErrorGenerateReport({
    required this.message,
  });
}
