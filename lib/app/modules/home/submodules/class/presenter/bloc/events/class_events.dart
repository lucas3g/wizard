// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

abstract class ClassEvents {}

class SaveClassEvent extends ClassEvents {
  final Class pClass;

  SaveClassEvent({required this.pClass});
}

class GetClassesByIdTeacher extends ClassEvents {
  final ClassIDTeacher idTeacher;

  GetClassesByIdTeacher({required this.idTeacher});
}
