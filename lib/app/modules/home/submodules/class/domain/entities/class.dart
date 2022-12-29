import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/types/entity.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_id_teacher.dart';
import 'package:wizard/app/modules/home/submodules/class/domain/vos/class_name.dart';

class Class extends Entity {
  ClassName _name;
  ClassIDTeacher _idTeacher;

  ClassName get name => _name;
  void setClassName(String value) => _name = ClassName(value);

  ClassIDTeacher get idTeacher => _idTeacher;
  void setIdTeacher(String value) => _idTeacher = ClassIDTeacher(value);

  Class({
    required super.id,
    required name,
    required idTeacher,
  })  : _name = ClassName(name),
        _idTeacher = ClassIDTeacher(idTeacher);

  @override
  Result<Class, String> validate([Object? object]) {
    return super
        .validate()
        .flatMap(name.validate)
        .flatMap(idTeacher.validate)
        .pure(this);
  }
}
