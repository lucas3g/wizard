import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/repositories/report_repository.dart';
import 'package:wizard/app/modules/home/submodules/report/domain/usecases/generate_file_pdf.dart';
import 'package:wizard/app/modules/home/submodules/report/external/report_datasource.dart';
import 'package:wizard/app/modules/home/submodules/report/infra/datasources/report_datasource.dart';
import 'package:wizard/app/modules/home/submodules/report/infra/repositories/report_repository.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/bloc/report_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/presenter/report_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class ReportModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IReportDatasource>(
      (i) => ReportDatasource(
        pdf: i(),
      ),
    ),

    //REPOSITORIES
    Bind.factory<IReportRepository>(
      (i) => ReportRepository(
        datasource: i(),
      ),
    ),

    //USECASES
    Bind.factory<IGenerateFilePDFUseCase>(
      (i) => GenerateFilePDFUseCase(
        repository: i(),
      ),
    ),

    BlocBind.factory<ReportBloc>(
      (i) => ReportBloc(
        generateFilePDFUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ReportPage(
            classBloc: Modular.get<ClassBloc>(),
            studentBloc: Modular.get<StudentBloc>(),
            reportBloc: Modular.get<ReportBloc>(),
            presenceBloc: Modular.get<PresenceBloc>(),
            homeworkBloc: Modular.get<HomeworkBloc>(),
          )),
    )
  ];
}
