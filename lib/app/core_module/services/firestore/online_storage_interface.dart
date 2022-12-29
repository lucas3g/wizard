import 'package:wizard/app/core_module/services/firestore/adapters/firestore_params.dart';

abstract class IOnlineStorage {
  Future<bool> saveData({required FireStoreParams params});
}
