// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const baseUrlLicense = String.fromEnvironment('BASE_URL_LICENSE');

class GlobalUser {
  final _shared = Modular.get<ILocalStorage>();

  static GlobalUser instance = GlobalUser().._carregaDados();

  late User? user =
      User(id: const IdVO('1'), name: '', email: '', photoURL: '');

  _carregaDados() {
    final result = _shared.getData('user');
    if (result != null) {
      user = UserAdapter.fromMap(jsonDecode(result));
    }
  }
}
