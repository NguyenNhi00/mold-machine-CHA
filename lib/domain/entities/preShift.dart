 
import 'package:equatable/equatable.dart';
import 'package:injection_molding_machine_application/domain/entities/login.dart';

import 'configuration.dart';

 class PreShift extends Equatable{
   DateTime? date;
   int? id;
   int? shiftNumber;
  Employee? employee;
  Machine? machine;
  Product? product;
   int? injectionCycle;
  int? cavity;
 int? totalQuantity;
  String? note;
   PreShift({
    this.date,
    this.id,
    this.shiftNumber,
    this.employee,
    this.machine,
    this.product,
    this.injectionCycle,
    this.cavity,
    this.totalQuantity,
    this.note}
  );
  @override
  List<Object?> get props => [
    date,
    id,
    shiftNumber,
    employee,
    machine,
    product,
    injectionCycle,
    cavity,
    totalQuantity,
    note
  ];
 }


