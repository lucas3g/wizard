// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class HomeworkStates {}

class InitialHomework extends HomeworkStates {}

class LoadingHomework extends HomeworkStates {}

class SuccessSaveHomework extends HomeworkStates {}

class ErrorSaveHomework extends HomeworkStates {
  final String message;

  ErrorSaveHomework({
    required this.message,
  });
}
