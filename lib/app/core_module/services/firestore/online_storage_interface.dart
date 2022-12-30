import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

abstract class IOnlineStorage {
  Future<bool> saveData({required FireStoreParams params});
  Future<QuerySnapshot<Map<String, dynamic>>> getDataById(
      {required FireStoreGetDataParams params});
}
