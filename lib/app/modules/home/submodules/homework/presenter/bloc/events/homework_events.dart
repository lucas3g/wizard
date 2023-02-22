// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/core_module/types/dates_entity.dart';
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

abstract class HomeworkEvents {}

class SaveHomeworkEvent extends HomeworkEvents {
  final Homework homework;

  SaveHomeworkEvent({
    required this.homework,
  });
}

class UpdateHomeworkEvent extends HomeworkEvents {
  final Homework homework;

  UpdateHomeworkEvent({
    required this.homework,
  });
}

class GetHomeworksByClassEvent extends HomeworkEvents {
  final int classID;

  GetHomeworksByClassEvent({
    required this.classID,
  });
}

class GetHomeworksByClassAndDateEvent extends HomeworkEvents {
  final int classID;
  final DatesEntity dates;

  GetHomeworksByClassAndDateEvent({
    required this.classID,
    required this.dates,
  });
}
