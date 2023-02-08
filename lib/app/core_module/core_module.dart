import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_interface.dart';
import 'package:wizard/app/core_module/services/pdf/pdf_service.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_interface.dart';
import 'package:wizard/app/core_module/services/supabase/supabase_service.dart';

import 'services/shared_preferences/local_storage_interface.dart';
import 'services/shared_preferences/shared_preferences_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
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

    //SUPABASE
    Bind<SupabaseClient>(
      (i) => Supabase.instance.client,
      export: true,
    ),

    //ONLINE STORAGE
    Bind<ISupaBase>(
      ((i) => SupaBaseService(supa: i())),
      export: true,
    ),

    Bind<IPDF>(
      ((i) => PDFService()),
      export: true,
    ),
  ];
}
