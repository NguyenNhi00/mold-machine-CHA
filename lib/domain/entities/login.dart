import 'package:equatable/equatable.dart';
//token, id , name

class User extends Equatable {
  final Token? token;
  final Employee? employee;
  const User(this.token, this.employee);
  @override
  List<Object?> get props => [token, employee];
}

class Token extends Equatable {
  final String? id;
  final String? authToken;
  final int? expiredIn;
  // constructor
  const Token(this.id, this.authToken, this.expiredIn);
  @override
  List<Object?> get props => [id, authToken, expiredIn];
}

class Employee extends Equatable {
  final String? employeeId;
  final String? firstname;
  final String? lastname;
  const Employee(this.employeeId, this.firstname, this.lastname);

  @override
  List<Object?> get props => [employeeId, firstname, lastname];
}
