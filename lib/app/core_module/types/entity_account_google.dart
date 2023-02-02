// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:result_dart/result_dart.dart';
import 'package:wizard/app/core_module/vos/id_account_google.dart';

abstract class EntityAccountGoogle {
  final IdAccountGoogleVO id;

  const EntityAccountGoogle({required this.id});

  Result<EntityAccountGoogle, String> validate([Object? object]) {
    return id.validate().pure(this);
  }

  @override
  bool operator ==(covariant EntityAccountGoogle other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
