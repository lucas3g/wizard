// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/utils/my_snackbar.dart';

class FireStoreService implements IOnlineStorage {
  final FirebaseFirestore firestore;

  FireStoreService({
    required this.firestore,
  });

  @override
  Future<bool> saveData({required FireStoreParams params}) async {
    try {
      await firestore.collection(params.collection).add(params.data);
      return true;
    } catch (e) {
      MySnackBar(message: e.toString());
      return false;
    }
  }

  @override
  Future<QuerySnapshot<Map<String, dynamic>>> getDataByIdTeacher(
      {required FireStoreParams params}) async {
    try {
      final result = await firestore
          .collection(params.collection)
          .where('idTeacher', isEqualTo: params.data['idTeacher'])
          .get();

      return result;
    } catch (e) {
      MySnackBar(message: e.toString());
      rethrow;
    }
  }
}
