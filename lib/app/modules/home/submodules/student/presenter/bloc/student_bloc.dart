// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_student_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/save_student_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';

class StudentBloc extends Bloc<StudentEvents, StudentStates> {
  final ISaveStudentUseCase saveStudentUseCase;
  final IGetStudentByClassUseCase getStudentByClassUseCase;

  StudentBloc({
    required this.saveStudentUseCase,
    required this.getStudentByClassUseCase,
  }) : super(InitialStudent()) {
    on<SaveStudentEvent>(_saveStudent);
    on<GetStudentByClassEvent>(_getStudentByClass);
  }

  Future _saveStudent(SaveStudentEvent event, emit) async {
    emit(LoadingStudent());

    final result = await saveStudentUseCase(event.student);

    result.fold(
      (success) => emit(SuccessSaveStudent()),
      (failure) => emit(ErrorStudent(message: failure.message)),
    );
  }

  Future _getStudentByClass(GetStudentByClassEvent event, emit) async {
    emit(LoadingStudent());

    final result = await getStudentByClassUseCase(event.classID);

    result.fold(
      (success) => emit(SuccessGetStudentByClass(students: success)),
      (failure) => emit(ErrorStudent(message: failure.message)),
    );
  }
}
