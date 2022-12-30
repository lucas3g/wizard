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
  Future<QuerySnapshot<Map<String, dynamic>>> getDataById(
      {required FireStoreGetDataParams params}) async {
    try {
      late QuerySnapshot<Map<String, dynamic>> result;

      final orderBy = params.orderBy;

      if (orderBy != null) {
        result = await firestore
            .collection(params.collection)
            .where(params.field, isEqualTo: params.value)
            .orderBy(orderBy)
            .get();

        return result;
      }

      result = await firestore
          .collection(params.collection)
          .where(params.field, isEqualTo: params.value)
          .get();

      return result;
    } catch (e) {
      MySnackBar(message: e.toString());
      rethrow;
    }
  }
}
