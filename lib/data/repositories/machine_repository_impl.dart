import 'package:injection_molding_machine_application/data/datasources/machine_service.dart';
import 'package:injection_molding_machine_application/data/models/configuration.dart';
import 'package:injection_molding_machine_application/data/models/machine_model.dart';
import 'package:injection_molding_machine_application/data/models/product_model.dart';
import 'package:injection_molding_machine_application/domain/repositories/machine_repoisitory.dart';

class MachineRepositoryImpl extends MachineRepository {
  final MachineService _machineService;
  MachineRepositoryImpl(this._machineService);
  @override
  Future<List<ProductModel>> getProductDetail() {
    return _machineService.getProductData();
  }
  @override
  Future<List<MachineModel>> getMachinesData(){
    return _machineService.getmachinesData();
  }
}
