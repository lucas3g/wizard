import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/student_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/widgets/edit_student_widget.dart';

class StudentModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: ((context, args) => StudentPage(
            studentBloc: Modular.get<StudentBloc>(),
          )),
    ),
    ChildRoute(
      '/edit',
      child: (context, args) => EditStudentWidget(
        classBloc: Modular.get<ClassBloc>(),
        studentBloc: Modular.get<StudentBloc>(),
      ),
    )
  ];
}
