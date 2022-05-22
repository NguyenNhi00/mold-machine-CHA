import 'package:injection_molding_machine_application/domain/entities/supervision.dart';

abstract class ModifyStatusMachineRepository {
  Future<void> requestModifyStatusMachine(Supervision supervision);
}
