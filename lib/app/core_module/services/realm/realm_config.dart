import 'package:realm/realm.dart';
import 'package:wizard/app/core_module/services/realm/model/theme_mode_model.dart';

LocalConfiguration config =
    Configuration.local([ThemeModeModel.schema], initialDataCallback: (realm) {
  realm.add(ThemeModeModel('dark'));
});
