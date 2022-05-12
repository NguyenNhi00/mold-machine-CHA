
import 'package:injection_molding_machine_application/domain/entities/configuration.dart';

abstract class MachineRepository {
  Future<List<Product>> getMachineDetail();
}
