
import 'package:injection_molding_machine_application/domain/entities/configuration.dart';
import 'package:injection_molding_machine_application/domain/repositories/machine_repoisitory.dart';
import 'package:injection_molding_machine_application/domain/repositories/modify_machine_status_repository.dart';

class GetMachineUseCase {
  final MachineRepository _machineRepository;
  final ModifyStatusMachineRepository _modifyStatusMachineRepository;
  GetMachineUseCase(
      this._machineRepository, this._modifyStatusMachineRepository);
  Future<List<Product>> getProductDetail() async {
    final product = await _machineRepository.getProductDetail();
    return product;
  }
  // Future<List<Machine>> getmachinesData() async{
  //   final machines = await _machineRepository.getMachinesData();
  //   return machines;
  // }

  Future<void> modifyStatusMachine() async {
    final request =
        await _modifyStatusMachineRepository.requestModifyMachineStatus();
  }
}
