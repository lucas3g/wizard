import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/auth/presenter/bloc/auth_bloc.dart';
import 'package:wizard/app/modules/home/presenter/home_page.dart';
import 'package:wizard/app/modules/home/submodules/class/class_module.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/get_classes_by_teacher_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/create_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/update_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/external/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/get_homework_by_class_and_date.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/get_homeworks_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/save_homework_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/update_homework_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/external/datasources/homework_datasource.dart';
import 'package:wizard/app/modules/home/submodules/homework/home_work_module.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_and_date.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/get_presences_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/update_presences_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/external/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/presence_module.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/report/report_module.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/get_review_by_class_and_date.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/get_review_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/save_review_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/update_review_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/external/datasources/review_datasource.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/review_module.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/repositories/student_repository.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_student_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_students_by_teacher.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/create_student_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/update_student_usecase.dart';
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
    Bind.factory<IClassDataSource>(
      (i) => ClassDataSource(client: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IClassRepository>(
      (i) => ClassRepository(dataSource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ICreateClassUseCase>(
      (i) => CreateClassUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IUpdateClassUseCase>(
      (i) => UpdateClassUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetClassesByTeacherUseCase>(
      (i) => GetClassesByTeacherUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<ClassBloc>(
      (i) => ClassBloc(
        createClassUseCase: i(),
        updateClassUseCase: i(),
        getClassesByTeacherUseCase: i(),
      ),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<IStudentDataSource>(
      (i) => StudentDataSource(client: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IStudentRepository>(
      (i) => StudentRepository(dataSource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ICreateStudentUseCase>(
      (i) => CreateStudentUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IUpdateStudentUseCase>(
      (i) => UpdateStudentUseCase(repository: i()),
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
        createStudentUseCase: i(),
        updateStudentUseCase: i(),
        getStudentByClassUseCase: i(),
        getStudentsByTeacherUseCase: i(),
      ),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<IPresenceDatasource>(
      (i) => PresenceDatasource(client: i()),
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
    Bind.factory<IUpdatePresencesUseCase>(
      (i) => UpdatePresencesUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetPresencesByClassUseCase>(
      (i) => GetPresencesByClassUseCase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetPresencesByClassAndDateUseCase>(
      (i) => GetPresencesByClassAndDateUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<PresenceBloc>(
      (i) => PresenceBloc(
        savePresenceUseCase: i(),
        getPresencesByClassUseCase: i(),
        getPresencesByClassAndDateUseCase: i(),
        updatePresencesUseCase: i(),
      ),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<IHomeworkDatasource>(
      (i) => HomeworkDatasource(client: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IHomeworkRepository>(
      (i) => HomeworkRepository(datasource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ISaveHomeworkUsecase>(
      (i) => SaveHomeworkUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IUpdateHomeworkUsecase>(
      (i) => UpdateHomeworkUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetHomeworksByClassUsecase>(
      (i) => GetHomeworksByClassUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetHomeworkByClassAndDateUseCase>(
      (i) => GetHomeworkByClassAndDateUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<HomeworkBloc>(
      (i) => HomeworkBloc(
        saveHomeworkUsecase: i(),
        getHomeworksByClassUsecase: i(),
        updateHomeworkUsecase: i(),
        getHomeworkByClassAndDateUseCase: i(),
      ),
      export: true,
    ),

    //DATASOURCES
    Bind.factory<IReviewDatasource>(
      (i) => ReviewDatasource(client: i()),
      export: true,
    ),

    //REPOSITORIES
    Bind.factory<IReviewRepository>(
      (i) => ReviewRepository(datasource: i()),
      export: true,
    ),

    //USECASES
    Bind.factory<ISaveReviewUsecase>(
      (i) => SaveReviewUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IUpdateReviewUsecase>(
      (i) => UpdateReviewUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetReviewsByClassUsecase>(
      (i) => GetReviewsByClassUsecase(repository: i()),
      export: true,
    ),
    Bind.factory<IGetReviewByClassAndDateUseCase>(
      (i) => GetReviewByClassAndDateUseCase(repository: i()),
      export: true,
    ),

    //BLOCS
    BlocBind.factory<ReviewBloc>(
      (i) => ReviewBloc(
        saveReviewUsecase: i(),
        updateReviewUsecase: i(),
        getReviewsByClassUsecase: i(),
        getReviewByClassAndDateUseCase: i(),
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
    ModuleRoute('/homework', module: HomeWorkModule()),
    ModuleRoute('/review', module: ReviewModule()),
    ModuleRoute('/report', module: ReportModule()),
  ];
}
