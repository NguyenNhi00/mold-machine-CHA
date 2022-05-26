import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injection_molding_machine_application/data/models/login_model.dart';

class LoginService {
  // Future<LoginModel> fetchToken() async{
  // }
  Future<LoginModel> getToken(String username, String password) async {
    final url =
        Uri.parse("https://sampleapiproject.azurewebsites.net/api/auth");
    final res = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username": username,
        "password": password,
      }),
    );
    if (res.statusCode == 200) {
      // ignore: avoid_print
      print('success');
      return LoginModel.fromJson(jsonDecode(res.body));
    } else {
      // ignore: avoid_print
      print('false');
      throw Exception('ahhjaj');
    }
  }
}
