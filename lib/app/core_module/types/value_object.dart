import 'package:result_dart/result_dart.dart';

abstract class ValueObject {
  Result<Unit, String> validate([Object? object]);
}
