// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:wizard/app/app_module.dart';
import 'package:wizard/app/app_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:wizard/app/core_module/constants/constants.dart';

Future<void> main() async {
  await initializeDateFormatting(await findSystemLocale(), '');
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: baseUrl,
    anonKey: apiKey,
  );

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
