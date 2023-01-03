import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/usecases/save_homework_usecase.dart';
import 'package:wizard/app/modules/home/submodules/homework/external/datasources/homework_datasource.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/datasources/homework_datasource.dart';
import 'package:wizard/app/modules/home/submodules/homework/infra/repositories/homework_repository.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/home_work_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class HomeWorkModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IHomeworkDatasource>(
      (i) => HomeworkDatasource(onlineStorage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IHomeworkRepository>(
      (i) => HomeworkRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<ISaveHomeworkUsecase>(
      (i) => SaveHomeworkUsecase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<HomeworkBloc>(
      (i) => HomeworkBloc(
        saveHomeworkUsecase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => HomeWorkPage(
            classBloc: Modular.get<ClassBloc>(),
            studentBloc: Modular.get<StudentBloc>(),
            homeworkBloc: Modular.get<HomeworkBloc>(),
          )),
    ),
  ];
}
