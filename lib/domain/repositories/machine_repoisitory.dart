
import 'dart:ffi';

import 'package:injection_molding_machine_application/domain/entities/configuration.dart';
import 'package:injection_molding_machine_application/domain/entities/preShift.dart';

abstract class MachineRepository {
  Future<List<Product>> getProductDetail();
  Future<List<PreShift>> getPreShiftData();
}
