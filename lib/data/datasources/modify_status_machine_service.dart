import 'dart:convert';

import 'package:injection_molding_machine_application/domain/entities/supervision.dart';
import 'package:http/http.dart' as http;

class ModifyStatusMachineService {
  List conditionList = [];
  Future<void> requestModifyStatusMachine(Supervision supervision) async {
    for(int i = 0; i < supervision.conditionCheck!.length; i++){
      Map<String,dynamic> conditionJson = {
        "name": supervision.conditionCheck![i].name.toString(),
        "checkPass": bool.fromEnvironment(supervision.conditionCheck![i].checkPass.toString())
      };
      conditionList.add(conditionJson);
    }
    final url = Uri.parse('');
    http.Response response = await http.post(url, headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
      body: jsonEncode(<String,dynamic>{
        'machineId': supervision.machineId.toString(),
        'conditionCheck': conditionList,
      })
      );
    if(response.statusCode == 200){
      conditionList = [];
      print('${response.statusCode} :Data posted!');
    }else{
      conditionList = [];
      print(response.statusCode);
      throw Exception('Post process failed !');
    }
  }
}
