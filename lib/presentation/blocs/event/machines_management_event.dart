import 'package:equatable/equatable.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';

class MachinesManagementEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchDetailMachinesEvent extends MachinesManagementEvent {
  @override
  List<Object?> get props => [];
}
class GetDataSignalEvent extends MachinesManagementEvent{
  NodeQueryResultModel nodeQueryResultModel;
  GetDataSignalEvent(this.nodeQueryResultModel);
  @override
  List<Object> get props => [];
}
