// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/homework/domain/entities/homework.dart';

abstract class HomeworkStates {}

class InitialHomework extends HomeworkStates {}

class LoadingHomework extends HomeworkStates {}

class SuccessSaveHomework extends HomeworkStates {}

class SuccessGetHomeworksByClass extends HomeworkStates {
  final List<Homework> homeworks;

  SuccessGetHomeworksByClass({
    required this.homeworks,
  });
}

class ErrorSaveHomework extends HomeworkStates {
  final String message;

  ErrorSaveHomework({
    required this.message,
  });
}
