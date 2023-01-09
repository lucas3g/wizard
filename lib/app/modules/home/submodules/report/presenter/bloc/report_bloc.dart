// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/report/domain/usecases/generate_file_pdf.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/events/report_events.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/states/report_states.dart';

class ReportBloc extends Bloc<ReportEvents, ReportStates> {
  final IGenerateFilePDFUseCase generateFilePDFUseCase;

  ReportBloc({
    required this.generateFilePDFUseCase,
  }) : super(InitialReport()) {
    on<GenerateReportPDFEvent>(_generatePDF);
  }

  Future _generatePDF(GenerateReportPDFEvent event, emit) async {
    emit(LoadingReport());

    final result = await generateFilePDFUseCase(event.report);

    result.fold(
      (success) => emit(SuccessGenerateReport()),
      (failure) => emit(ErrorGenerateReport(message: failure.message)),
    );
  }
}
