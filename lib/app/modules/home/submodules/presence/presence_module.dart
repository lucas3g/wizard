import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/bloc/presence_bloc.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/presence_page.dart';
import 'package:wizard/app/modules/home/submodules/presence/presenter/widgets/presence_list_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class PresenceModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

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
    ChildRoute(
      '/list',
      child: ((context, args) => PresenceListPage(
            classBloc: Modular.get<ClassBloc>(),
            studentBloc: Modular.get<StudentBloc>(),
            presenceBloc: Modular.get<PresenceBloc>(),
          )),
    ),
  ];
}
