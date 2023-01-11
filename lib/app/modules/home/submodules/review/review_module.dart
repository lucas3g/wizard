import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/review_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class ReviewModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => ReviewPage(
            classBloc: Modular.get<ClassBloc>(),
            studentBloc: Modular.get<StudentBloc>(),
            reviewBloc: Modular.get<ReviewBloc>(),
          )),
    ),
  ];
}
