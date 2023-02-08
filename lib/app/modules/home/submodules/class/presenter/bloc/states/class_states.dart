// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/home/submodules/class/domain/entities/class.dart';

abstract class ClassStates {}

class InitialClass extends ClassStates {}

class LoadingClass extends ClassStates {}

class SuccessCreateClass extends ClassStates {}

class SuccessUpdateClass extends ClassStates {}

class SuccessGetListClass extends ClassStates {
  final List<Class> classes;

  SuccessGetListClass({
    required this.classes,
  });
}

class ErrorClass extends ClassStates {
  final String message;

  ErrorClass({required this.message});
}
