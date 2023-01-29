// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wizard/app/core_module/services/shared_preferences/local_storage_interface.dart';
import 'package:wizard/app/core_module/vos/id_vo.dart';
import 'package:wizard/app/modules/auth/domain/entities/user_entity.dart';
import 'package:wizard/app/modules/auth/infra/adapters/user_adapter.dart';

const baseUrl = String.fromEnvironment('BASE_URL');
const apiKey = String.fromEnvironment('API_KEY');

final notes = [
  {'type': 'O', 'name': 'Ótimo'},
  {'type': 'MB', 'name': 'Muito bom'},
  {'type': 'B', 'name': 'Bom'},
  {'type': 'R', 'name': 'Regular'},
];

Color makeBackGroundColorListTile(String score) {
  switch (score) {
    case 'O':
      return Colors.green.shade400;
    case 'MB':
      return Colors.blue.shade400;
    case 'B':
      return Colors.orange.shade400;
    case 'R':
      return Colors.red.shade400;
    default:
      return Colors.white;
  }
}

class GlobalUser {
  GlobalUser._();

  static GlobalUser instance = GlobalUser._();

  User get user {
    final shared = Modular.get<ILocalStorage>();

    final result = shared.getData('user');

    if (result != null) {
      final user = UserAdapter.fromMap(jsonDecode(result));
      return user;
    }

    return User(id: const IdVO('1'), name: '', email: '', photoURL: '');
  }
}
