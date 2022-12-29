abstract class ClassStates {}

class InitialClass extends ClassStates {}

class LoadingClass extends ClassStates {}

class SuccessClass extends ClassStates {}

class ErrorClass extends ClassStates {
  final String message;

  ErrorClass({required this.message});
}
