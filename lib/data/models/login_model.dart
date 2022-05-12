
import 'package:injection_molding_machine_application/domain/entities/login.dart';

class LoginModel extends User {
  const LoginModel({Token? token, Employee? employee}) : super(token, employee);

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        token: TokenModel(
          authToken: json['token']['authToken'],
          expiredIn: json['token']['expiredIn'],
          id: json['token']['id']
        ), 
        employee:EmployeeModel(
          employeeId: json['employee']['employeeId'],
          firstname: json['employee']['firstname'],
          lastname: json['employee']['lastname']
        )
        );
  }
}

class TokenModel extends Token {
  const TokenModel({String? id, String? authToken, int? expiredIn})
      : super(id, authToken, expiredIn);
  factory TokenModel.fromJson(Map<String, dynamic> json) {
    return TokenModel(
      id: json["id"] as String,
      authToken: json["authToken"] as String,
      expiredIn: json["expiredIn"] as int,
    );
  }
}

class EmployeeModel extends Employee {
  const EmployeeModel({String? employeeId, String? firstname, String? lastname})
      : super(employeeId, firstname, lastname);

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      employeeId: json["employeeId"] as String,
      firstname: json["firstname"] as String,
      lastname: json["lastname"] as String,
    );
  }
}
