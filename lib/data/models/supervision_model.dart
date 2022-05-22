import 'package:injection_molding_machine_application/domain/entities/supervision.dart';

class SupervisionModel extends Supervision{
  String? machineId;
  List<ConditionCheckModel>? conditionCheckModel;
  SupervisionModel({ this.conditionCheckModel, this.machineId}):super(machineId,conditionCheckModel);
  @override 
  List<Object?> get props => [machineId,conditionCheckModel];
  
} 

class ConditionCheckModel extends ConditionCheck{
  String name;
  bool checkpass;
  ConditionCheckModel({required this.checkpass, required this.name}):super(checkPass: checkpass, name: name);
  
  @override 
  List<Object> get props => [name,checkpass];
}