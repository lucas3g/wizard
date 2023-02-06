// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';

abstract class Entity {
  IdVO id;

  void setId(int value) => id = IdVO(value);

  Entity({required this.id});

  Result<Entity, String> validate([Object? object]) {
    return id.validate().pure(this);
  }

  @override
  bool operator ==(covariant Entity other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
