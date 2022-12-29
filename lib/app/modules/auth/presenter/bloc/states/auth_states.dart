// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';

abstract class AuthStates {}

class InitialAuth extends AuthStates {}

class LoadignAuth extends AuthStates {}

class SuccessAuth extends AuthStates {
  final User user;

  SuccessAuth({
    required this.user,
  });
}

class ErrorAuth extends AuthStates {
  final String message;

  ErrorAuth({
    required this.message,
  });
}
