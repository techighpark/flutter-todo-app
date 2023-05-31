import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ListRepository {
  static const String _list = "tech_list";
  final SharedPreferences _preferences;

  ListRepository(this._preferences);

  Future<void> setList(List<String> value) async {
    _preferences.setStringList(_list, value);
  }

  List<String> getList() {
    return _preferences.getStringList(_list) ?? [];
  }
}
