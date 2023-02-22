import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/shared/stores/app_store.dart';

class ThemeModeController {
  static ThemeMode get themeMode => Modular.get<AppStore>().themeMode.value;
}
