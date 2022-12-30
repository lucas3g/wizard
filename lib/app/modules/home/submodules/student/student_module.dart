import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/get_classes_by_teacher_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/save_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/external/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/student_page.dart';

class StudentModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IClassDataSource>((i) => ClassDataSource(onlineStorage: i())),

    //REPOSITORIES
    Bind.factory<IClassRepository>((i) => ClassRepository(dataSource: i())),

    //USECASES
    Bind.factory<ISaveClassUseCase>((i) => SaveClassUseCase(repository: i())),
    Bind.factory<IGetClassesByTeacherUseCase>(
        (i) => GetClassesByTeacherUseCase(repository: i())),

    //BLOCS
    BlocBind.factory<ClassBloc>((i) =>
        ClassBloc(saveClassUseCase: i(), getClassesByTeacherUseCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) =>
          StudentPage(classBloc: Modular.get<ClassBloc>())),
    ),
  ];
}
