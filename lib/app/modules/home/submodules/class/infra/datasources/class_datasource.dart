import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';

abstract class IClassDataSource {
  Future<bool> saveClass(Class pClass);
  Future<List> getClassesByTeacher(ClassIDTeacher idTeacher);
}
