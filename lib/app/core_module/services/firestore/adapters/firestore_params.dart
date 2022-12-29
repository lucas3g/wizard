// ignore_for_file: public_member_api_docs, sort_constructors_first
class FireStoreParams {
  final String collectionPath;
  final String doc;
  final Map<String, dynamic> data;

  FireStoreParams({
    required this.collectionPath,
    required this.doc,
    required this.data,
  });
}
