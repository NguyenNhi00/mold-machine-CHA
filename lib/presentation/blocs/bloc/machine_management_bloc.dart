

import 'package:bloc/bloc.dart';
import 'package:injection_molding_machine_application/domain/usecases/machine_usecase.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machines_management_event.dart';
import 'dart:async';

import 'package:signalr_core/signalr_core.dart';

late HubConnection hubConnection;
class MachinesManagementBloc
    extends Bloc<MachinesManagementEvent, MachineManagementState> {
  final GetMachineUseCase _getMachineUseCase;
  MachinesManagementBloc(this._getMachineUseCase)
      : super(MachineManagementStateUnLoad()) {
    on<FetchDetailMachinesEvent>(onFetchDetailMachines);
  }
  Future<void> onFetchDetailMachines(MachinesManagementEvent event,
      Emitter<MachineManagementState> emit) async {
    if (event is FetchDetailMachinesEvent) {
      final res = await _getMachineUseCase.getProductDetail();
      final product = res;
       final response = await _getMachineUseCase.getpreShiftData();
      final preShift = response;
      return emit(MachineManagementStateLoaded(preShift,[],product));
    }
  }
}
