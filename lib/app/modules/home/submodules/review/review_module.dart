import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'package:wizard/app/modules/home/submodules/class/presenter/bloc/class_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/domain/usecases/save_review_usecase.dart';
import 'package:wizard/app/modules/home/submodules/review/external/datasources/review_datasource.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/datasources/review_datasource.dart';
import 'package:wizard/app/modules/home/submodules/review/infra/repositories/review_repository.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/bloc/review_bloc.dart';
import 'package:wizard/app/modules/home/submodules/review/presenter/review_page.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/student_bloc.dart';

class ReviewModule extends Module {
  @override
  final List<Module> imports = [];

  @override
  final List<Bind<Object>> binds = [
    //DATASOURCES
    Bind.factory<IReviewDatasource>(
      (i) => ReviewDatasource(onlineStorage: i()),
    ),

    //REPOSITORIES
    Bind.factory<IReviewRepository>(
      (i) => ReviewRepository(datasource: i()),
    ),

    //USECASES
    Bind.factory<ISaveReviewUsecase>(
      (i) => SaveReviewUsecase(repository: i()),
    ),

    //BLOCS
    BlocBind.factory<ReviewBloc>(
      (i) => ReviewBloc(
        saveReviewUsecase: i(),
      ),
    ),
  ];

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
