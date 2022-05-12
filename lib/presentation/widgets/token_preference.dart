import 'dart:convert';

import 'package:injection_molding_machine_application/data/models/login_model.dart';
import 'package:injection_molding_machine_application/domain/entities/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPreference {
  static SharedPreferences? _preferences;
  static Future init() async{
    return _preferences = await SharedPreferences.getInstance();
  }
   static Future setToken(Token token) async {
     String tokenJson = jsonEncode(token);
    return await _preferences
        ?.setString('token',tokenJson);
  }
  static TokenModel? getToken() {
   // Map json = jsonDecode();
   
  }
}