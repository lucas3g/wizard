// ignore_for_file: public_member_api_docs, sort_constructors_first
class FireStoreParams {
  final String collection;
  final Map<String, dynamic> data;

  FireStoreParams({
    required this.collection,
    required this.data,
  });
}

class FireStoreSaveOrUpdateParams {
  final String collection;
  final String doc;
  final Map<String, dynamic> data;

  FireStoreSaveOrUpdateParams({
    required this.collection,
    required this.doc,
    required this.data,
  });
}

class FireStoreGetDataByCollectionParams {
  final String collection;
  final String doc;
  final String field;
  final String? orderBy;

  FireStoreGetDataByCollectionParams({
    required this.collection,
    required this.doc,
    required this.field,
    this.orderBy,
  });
}

class FireStoreGetDataParams {
  final String collection;
  final String field;
  final String value;
  final String? orderBy;

  FireStoreGetDataParams({
    required this.collection,
    required this.field,
    required this.value,
    this.orderBy,
  });
}
