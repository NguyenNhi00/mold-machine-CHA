import 'package:equatable/equatable.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';

import 'package:injection_molding_machine_application/domain/entities/configuration.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';

class MachineManagementState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MachineManagementStateUnLoad extends MachineManagementState {}

class MachineManagementStateLoading extends MachineManagementState {}

class MachineManagementStateLoaded extends MachineManagementState {
  // List<Machine> machines ;
  List<Product> productList;
  List<DeviceQueryResult> deviceQueryResult;
  MachineManagementStateLoaded(this.deviceQueryResult, this.productList);
  @override
  List<Object?> get props => [deviceQueryResult,productList];
}

class MachineManagementStateLoadFail extends MachineManagementState {}

