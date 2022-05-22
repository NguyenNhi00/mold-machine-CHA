
import 'dart:ffi';

import 'package:injection_molding_machine_application/domain/entities/supervision.dart';
import 'package:injection_molding_machine_application/domain/repositories/modify_machine_status_repository.dart';

class ModifyMachineStatusUsecase {
  ModifyStatusMachineRepository modifyStatusMachineRepository;
  ModifyMachineStatusUsecase(this.modifyStatusMachineRepository);
  Future<void> requestModifyStatusMachine(Supervision supervision) async{
    modifyStatusMachineRepository.requestModifyStatusMachine(supervision);
  }
}