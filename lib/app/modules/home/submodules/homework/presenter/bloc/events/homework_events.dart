// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

abstract class HomeworkEvents {}

class SaveHomeworkEvent extends HomeworkEvents {
  final Homework homework;

  SaveHomeworkEvent({
    required this.homework,
  });
}
