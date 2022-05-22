import 'dart:ffi';

import 'package:injection_molding_machine_application/data/datasources/machine_service.dart';
import 'package:injection_molding_machine_application/data/datasources/modify_status_machine_service.dart';
import 'package:injection_molding_machine_application/data/models/product_model.dart';
import 'package:injection_molding_machine_application/domain/entities/preShift.dart';
import 'package:injection_molding_machine_application/domain/entities/supervision.dart';
import 'package:injection_molding_machine_application/domain/repositories/machine_repoisitory.dart';

class MachineRepositoryImpl extends MachineRepository {
  final MachineService _machineService;
  final ModifyStatusMachineService _modifyStatusMachineService;
  MachineRepositoryImpl(this._machineService, this._modifyStatusMachineService);
  @override
  Future<List<ProductModel>> getProductDetail() {
    return _machineService.getProductData();
  }

  @override
  Future<List<PreShift>> getPreShiftData() {
    return _machineService.getPreShiftData();
  }
  @override
  Future<void> sendConditionCheck(Supervision supervision) async{
    return _modifyStatusMachineService.requestModifyStatusMachine(supervision);
  }
}
