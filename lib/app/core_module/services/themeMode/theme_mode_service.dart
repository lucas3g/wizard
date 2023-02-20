// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:realm/realm.dart';
import 'package:wizard/app/core_module/services/realm/model/theme_mode_model.dart';

abstract class IThemeMode {
  ThemeModeModel getThemeMode();
  Future saveThemeMode(String themeModeName);
}

class ThemeModeService implements IThemeMode {
  final Realm realm;

  ThemeModeService({
    required this.realm,
  });

  @override
  ThemeModeModel getThemeMode() {
    return realm.all<ThemeModeModel>().first;
  }

  @override
  Future saveThemeMode(String themeModeName) async {
    final model = getThemeMode();

    realm.write(() {
      model.themeModeName = themeModeName;
    });
  }
}
