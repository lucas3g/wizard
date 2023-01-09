import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/home/presenter/home_page.dart';
import 'package:wizard/app/modules/home/submodules/class/class_module.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/get_classes_by_teacher_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/save_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/external/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/home_work_module.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/external/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/presence_module.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/report_module.dart';
import 'package:wizard/app/modules/home/submodules/review/review_module.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_student_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_students_by_teacher.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/save_student_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/external/datasources/student_datasource.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/datasources/student_datasource.dart';
import 'package:wizard/app/modules/home/submodules/student/infra/repositories/student_repository.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/modules/home/submodules/student/student_module.dart';

class HomeModule extends Module {
  @override
  final List<Module> imports = [
    StudentModule(),
    ClassModule(),
    PresenceModule(),
    HomeWorkModule(),
    ReviewModule(),
    ReportModule(),
  ];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IClassDataSource>((i) => ClassDataSource(onlineStorage: i()),
        export: true),

    //REPOSITORIES
    Bind.factory<IClassRepository>((i) => ClassRepository(dataSource: i()),
        export: true),

    //USECASES
    Bind.factory<ISaveClassUseCase>((i) => SaveClassUseCase(repository: i()),
        export: true),
    Bind.factory<IGetClassesByTeacherUseCase>(
        (i) => GetClassesByTeacherUseCase(repository: i()),
        export: true),

    //BLOCS
    BlocBind.factory<ClassBloc>(
        (i) =>
            ClassBloc(saveClassUseCase: i(), getClassesByTeacherUseCase: i()),
        export: true),

    //DATASOURCES
    Bind.factory<IStudentDataSource>(
      (i) => StudentDataSource(onlineStorage: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IStudentRepository>(
      (i) => StudentRepository(dataSource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ISaveStudentUseCase>(
      (i) => SaveStudentUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetStudentByClassUseCase>(
      (i) => GetStudentByClassUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetStudentsByTeacherUseCase>(
      (i) => GetStudentsByTeacherUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<StudentBloc>(
      (i) => StudentBloc(
        saveStudentUseCase: i(),
        getStudentByClassUseCase: i(),
        getStudentsByTeacherUseCase: i(),
      ),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<IPresenceDatasource>(
      (i) => PresenceDatasource(onlineStorage: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IPresenceRepository>(
      (i) => PresenceRepository(datasource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ISavePresenceUseCase>(
      (i) => SavePresenceUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetPresencesByClassUseCase>(
      (i) => GetPresencesByClassUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<PresenceBloc>(
      (i) => PresenceBloc(
        savePresenceUseCase: i(),
        getPresencesByClassUseCase: i(),
      ),
      export: true,
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => HomePage(
            authBloc: Modular.get<AuthBloc>(),
          )),
    ),
    ModuleRoute('/student', module: StudentModule()),
    ModuleRoute('/class', module: ClassModule()),
    ModuleRoute('/presence', module: PresenceModule()),
    ModuleRoute('/homeWork', module: HomeWorkModule()),
    ModuleRoute('/review', module: ReviewModule()),
    ModuleRoute('/report', module: ReportModule()),
  ];
}
