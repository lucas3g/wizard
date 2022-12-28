// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:result_dart/result_dart.dart';

abstract class ValueObject<T> {
  final T value;

  const ValueObject(this.value);

  Result<ValueObject<T>, String> validate([Object? object]);

  @override
  bool operator ==(covariant ValueObject<T> other) {
    if (identical(this, other)) return true;

    return other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() {
    return '$runtimeType: $value';
  }
}
