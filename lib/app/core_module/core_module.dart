import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wizard/app/core_module/services/firestore/firestore_service.dart';
import 'package:wizard/app/core_module/services/firestore/online_storage_interface.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_interface.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_service.dart';

import 'services/shared_preferences/local_storage_interface.dart';
import 'services/shared_preferences/shared_preferences_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'services/client_http/client_http_interface.dart';
import 'services/client_http/dio_client_http.dart';

Bind<Dio> _dioFactory() {
  final baseOptions = BaseOptions(
    // baseUrl: baseUrl,
    headers: {'Content-Type': 'application/json'},
  );
  return Bind.factory<Dio>((i) => Dio(baseOptions), export: true);
}

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    //DIO
    _dioFactory(),

    //CLIENTHTTP
    Bind.factory<IClientHttp>(
      (i) => DioClientHttp(i()),
      export: true,
    ),

    //SHARED PREFERENCES
    AsyncBind<SharedPreferences>(
      (i) => SharedPreferences.getInstance(),
      export: true,
    ),

    //LOCAL STORAGE
    Bind<ILocalStorage>(
      ((i) => SharedPreferencesService(sharedPreferences: i())),
      export: true,
    ),

    //FIREBASE FIRESTORE
    Bind<FirebaseFirestore>(
      (i) => FirebaseFirestore.instance,
      export: true,
    ),

    //ONLINE STORAGE
    Bind<IOnlineStorage>(
      ((i) => FireStoreService(firestore: i())),
      export: true,
    ),

    Bind<IPDF>(
      ((i) => PDFService()),
      export: true,
    ),
  ];
}
