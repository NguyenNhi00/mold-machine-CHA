

import 'package:injection_molding_machine_application/data/models/login_model.dart';
import 'package:injection_molding_machine_application/data/models/machine_model.dart';
import 'package:injection_molding_machine_application/data/models/product_model.dart';
import 'package:injection_molding_machine_application/domain/entities/preShift.dart';

class PreShiftModel extends PreShift{
  PreShiftModel({
    DateTime? date,
   int? id,
   int? shiftNumber,
  EmployeeModel? employee,
  MachineModel? machine,
  ProductModel? product,
   int? injectionCycle,
  int? cavity,
 int? totalQuantity,
  String? note
  }):super(
    date: date,
    id: id,
    shiftNumber: shiftNumber,
    employee: employee,
    machine: machine,
    product: product,
    injectionCycle: injectionCycle,
    cavity: cavity,
    totalQuantity:totalQuantity,
    note: note,
  );
  factory PreShiftModel.fromJson(Map<String, dynamic> json){
    return PreShiftModel(
     date: json['date'],
     id: json['shiftNumber'] as int,
     shiftNumber: json['shiftNumber'],
     employee: json['employee'] != null
        ?  EmployeeModel.fromJson(json['employee'])
        : null,
      machine :
        json['machine'] != null ? MachineModel.fromJson(json['machine']) : null,
    product :
        json['product'] != null ? ProductModel.fromJson(json['product']) : null,
    injectionCycle: json['injectionCycle'] as int,
    cavity : json['cavity'] as int,
    totalQuantity : json['totalQuantity'] as int,
    note : json['note'] as String,
    );
  }
}