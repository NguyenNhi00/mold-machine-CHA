import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query.dart';
import 'package:injection_molding_machine_application/domain/usecases/machine_usecase.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'dart:async';

import 'package:signalr_core/signalr_core.dart';

late HubConnection hubConnection;
class MachinesManagementBloc
    extends Bloc<MachinesManagementEvent, MachineManagementState> {
  final GetMachineUseCase _getMachineUseCase;
  MachinesManagementBloc(this._getMachineUseCase)
      : super(MachineManagementStateUnLoad()) {
    on<FetchDetailMachinesEvent>(onFetchDetailMachines);
    on<GetDataSignalEvent>(onGetDataSignalEvent);
  }
  Future<void> onFetchDetailMachines(MachinesManagementEvent event,
      Emitter<MachineManagementState> emit) async {
    if (event is FetchDetailMachinesEvent) {
      final res = await _getMachineUseCase.getProductDetail();
      final product = res;
      // final response = await _getMachineUseCase.getmachinesData();
      // final machines = response;
      return emit(MachineManagementStateLoaded([],product));
    }
  }
  Future<void> onGetDataSignalEvent(MachinesManagementEvent event, Emitter<MachineManagementState> emit) async {
    if (event is GetDataSignalEvent) {
      List<String> tagQueryL6 = [
        'L6.CycleTime',
        'L6.OpenTime',
        'L6.CounterShot',
        'L6.SetCycle',
        'L6.MachineStatus'
      ];
      // List<String> tagQueryL7 = [
      //   'L7.CycleTime',
      //   'L7.OpenTime',
      //   'L7.CounterShot',
      //   'L7.SetCycle',
      //   'L7.MachineStatus'
      // ];
      List<String> tagQueryList = 
          [
            '$tagQueryL6', 
           // '$tagQueryL7'
            ];
      DeviceQuery deviceQueryL6 = DeviceQuery(deviceId: 'l6', tagNames: tagQueryL6);
      List<DeviceQuery> deviceQueries = [deviceQueryL6];
      NodeQuery nodeQuery =
          NodeQuery(eonNodeId: 'imm', deviceQueries: deviceQueries);
      List deviceQueryJsons = [];
      // toJson
      for (int i = 0; i < deviceQueries.length; i++) {
        Map<String, dynamic> deviceQueryJson = {
          'DeviceId': deviceQueries[i].deviceId,
          'Tagnames': deviceQueries[i].tagNames,
        };
        deviceQueryJsons.add(deviceQueryJson);
      }
      Map<String, dynamic> nodeQueryjson = {
        'EonNodeId': 'imm',
        'DeviceQueries': deviceQueryJsons
      };
      String json = jsonEncode(nodeQueryjson);
      print(json);

      // connect to server

      hubConnection = HubConnectionBuilder()
          .withUrl(Constants.signalRUrl)
          .withAutomaticReconnect()
          .build();
      // hubConnection.keepAliveIntervalInMilliseconds = 15000;
      hubConnection.serverTimeoutInMilliseconds = 100000;
      hubConnection.onclose((error) => print("Connection Closed"));
      await hubConnection.start();
      if (hubConnection.state == HubConnectionState.connected) {
        print(hubConnection.state);
        var nodeQueryResultSignalR = await hubConnection
            .invoke("GetListTagsWithJson", args: <String>[json.toString()]);
        print(nodeQueryResultSignalR);
        event.nodeQueryResultModel =
            NodeQueryResultModel.fromJson(nodeQueryResultSignalR);
        print(event.nodeQueryResultModel.deviceQueryResults.length);
      }
      return emit(GetDataSignalRState(event.nodeQueryResultModel));
    }
  }
}
