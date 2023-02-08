// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_student_by_class_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/get_students_by_teacher.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/create_student_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/domain/usecases/update_student_usecase.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/events/student_events.dart';
import 'package:wizard/app/modules/home/submodules/student/presenter/bloc/states/student_states.dart';

class StudentBloc extends Bloc<StudentEvents, StudentStates> {
  final ICreateStudentUseCase createStudentUseCase;
  final IUpdateStudentUseCase updateStudentUseCase;
  final IGetStudentByClassUseCase getStudentByClassUseCase;
  final IGetStudentsByTeacherUseCase getStudentsByTeacherUseCase;

  StudentBloc({
    required this.createStudentUseCase,
    required this.updateStudentUseCase,
    required this.getStudentByClassUseCase,
    required this.getStudentsByTeacherUseCase,
  }) : super(InitialStudent()) {
    on<CreateStudentEvent>(_saveStudent);
    on<UpdateStudentEvent>(_updateStudent);
    on<GetStudentByClassEvent>(_getStudentByClass);
    on<GetStudentByTeacherEvent>(_getStudentByTeacher);
  }

  Future _saveStudent(CreateStudentEvent event, emit) async {
    emit(LoadingStudent());

    final result = await createStudentUseCase(event.student);

    result.fold(
      (success) => emit(SuccessCreateStudent()),
      (failure) => emit(ErrorStudent(message: failure.message)),
    );
  }

  Future _updateStudent(UpdateStudentEvent event, emit) async {
    emit(LoadingStudent());

    final result = await updateStudentUseCase(event.student);

    result.fold(
      (success) => emit(SuccessUpdateStudent()),
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

  Future _getStudentByTeacher(GetStudentByTeacherEvent event, emit) async {
    emit(LoadingStudent());

    final result = await getStudentsByTeacherUseCase(event.teacherID);

    result.fold(
      (success) => emit(SuccessGetStudentByTeacher(students: success)),
      (failure) => emit(ErrorStudent(message: failure.message)),
    );
  }
}
