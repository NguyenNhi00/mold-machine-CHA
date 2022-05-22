import 'package:equatable/equatable.dart';

class Supervision extends Equatable{
  String? machineId;
  List<ConditionCheck>? conditionCheck;
  Supervision(
     this.machineId,
     this.conditionCheck,
);
  @override
  List<Object?> get props => [machineId,conditionCheck];
}
class ConditionCheck extends Equatable{
  String name;
  bool checkPass;
  ConditionCheck({required this.checkPass, required this.name});
  @override
  List<Object> get props => [name,checkPass];
}