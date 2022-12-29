import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/usecases/save_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/class/external/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/datasources/class_datasource.dart';
import 'package:wizard/app/modules/home/submodules/class/infra/repositories/class_repository.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/class_page.dart';

class ClassModule extends Module {
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

    //BLOCS
    BlocBind.factory<ClassBloc>((i) => ClassBloc(saveClassUseCase: i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ClassPage(
            classBloc: Modular.get<ClassBloc>(),
          )),
    ),
  ];
}
