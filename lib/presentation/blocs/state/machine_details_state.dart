
import 'package:equatable/equatable.dart';
import 'package:injection_molding_machine_application/data/models/error_package.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/presentation/widgets/dialog.dart';

abstract class MachineDetailsState extends Equatable {}

class MachineDetailsStateInit extends MachineDetailsState {
 NodeQueryResultModel nodeQueryResultModel;
 MachineDetailsStateInit({ required this.nodeQueryResultModel});
  @override
  List<Object?> get props => [nodeQueryResultModel];}

class MachineDetailsStateLoadingRequest extends MachineDetailsState {
  DateTime timestamp;
  // late ErrorPackage errorPackage;
  MachineDetailsStateLoadingRequest({required this.timestamp});

  @override
  List<Object> get props => [timestamp];
}

class MachineDetailsStateConnectSuccessful extends MachineDetailsState {
  // DateTime timestamp;
 
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class MachineDetailsStateConnectFail extends MachineDetailsState {

  MachineDetailsStateConnectFail();
  @override
  List<Object> get props => [];
}

class MachineDetailsStateDataUpdated extends MachineDetailsState {
  NodeQueryResultModel nodeQueryResultModel;
  MachineDetailsStateDataUpdated({required this.nodeQueryResultModel});
  @override
  // TODO: implement props
  List<Object> get props => [nodeQueryResultModel];
}
