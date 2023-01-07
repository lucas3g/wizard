import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/class_page.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/widgets/edit_class_widget.dart';

class ClassModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ClassPage(
            classBloc: Modular.get<ClassBloc>(),
          )),
    ),
    ChildRoute(
      '/edit',
      child: ((context, args) => EditClassWidget(
            classBloc: Modular.get<ClassBloc>(),
          )),
    ),
  ];
}
