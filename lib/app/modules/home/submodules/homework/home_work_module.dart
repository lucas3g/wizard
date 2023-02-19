import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/bloc/homework_bloc.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/home_work_page.dart';
import 'package:wizard/app/modules/home/submodules/homework/presenter/widgets/home_work_list_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class HomeWorkModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

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
    ChildRoute(
      '/list',
      child: ((context, args) => HomeworkListPage(
            classBloc: Modular.get<ClassBloc>(),
            homeworkBloc: Modular.get<HomeworkBloc>(),
          )),
    ),
  ];
}
