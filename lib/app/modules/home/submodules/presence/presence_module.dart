import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/domain/usecases/save_presence_usecase.dart';
import 'package:wizard/app/modules/home/submodules/presence/external/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/datasources/presence_datasource.dart';
import 'package:wizard/app/modules/home/submodules/presence/infra/repositories/presence_repository.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/presence_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class PresenceModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IPresenceDatasource>(
      (i) => PresenceDatasource(onlineStorage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IPresenceRepository>(
      (i) => PresenceRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<ISavePresenceUseCase>(
      (i) => SavePresenceUseCase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<PresenceBloc>(
      (i) => PresenceBloc(
        savePresenceUseCase: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => PresencePage(
            classBloc: Modular.get<ClassBloc>(),
            studentBloc: Modular.get<StudentBloc>(),
            presenceBloc: Modular.get<PresenceBloc>(),
          )),
    ),
  ];
}
