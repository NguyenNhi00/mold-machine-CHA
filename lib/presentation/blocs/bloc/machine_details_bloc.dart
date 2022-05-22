import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_molding_machine_application/data/models/error_package.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/mold.dart';
import 'package:injection_molding_machine_application/domain/entities/mold_monitor.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machine_details_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machine_details_state.dart';
import 'package:bloc/bloc.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:signalr_core/signalr_core.dart';

Mold? moldCurrent;
MoldMonitor? moldMonitor;
late HubConnection hubConnection;

class MachineDetailsBloc extends Bloc<MachineEvent, MachineDetailsState> {
  MachineDetailsBloc()
      : super(MachineDetailsStateInit(
            nodeQueryResultModel: NodeQueryResultModel(
                connected: false, deviceQueryResults: [], eonNodeId: ''))) {
    on<MachineDetailsEventDataUpDated>(onGetDataSignalR);

    on<MachineDetailsEventHubConnected>(
        (event, emit) => MachineDetailsStateConnectSuccessful());
    on<MachineDetailsEventConnectFail>((event, emit) =>
        MachineDetailsStateConnectFail(
            errorPackage: ErrorPackage(
                errorCode: "error",
                message: "Ngắt kết nối",
                detail: "Đã ngắt kết nối tới máy chủ")));
  }
  Future<void> onGetDataSignalR(
      MachineEvent event, Emitter<MachineDetailsState> emit) async {
    if (event is MachineDetailsEventDataUpDated) {
      List<String> tagQueryL6 = [
        'L6.CycleTime',
        'L6.OpenTime',
        'L6.CounterShot',
        'L6.SetCycle',
        'L6.MachineStatus'
      ];
      List<String> tagQueryL10 = [
        'L10.CycleTime',
        'L10.OpenTime',
        'L10.CounterShot',
        'L10.SetCycle',
        'L10.MachineStatus'
      ];
      List<String> tagQueryList = 
          [
            '$tagQueryL6', 
           '$tagQueryL10'
            ];
      DeviceQuery deviceQueryL6 = DeviceQuery(deviceId: 'l6', tagNames: tagQueryL6);
       DeviceQuery deviceQueryL10 = DeviceQuery(deviceId: 'l10', tagNames: tagQueryL10);
      List<DeviceQuery> deviceQueries = [deviceQueryL6,deviceQueryL10];
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
       hubConnection.keepAliveIntervalInMilliseconds = 15000;
      hubConnection.serverTimeoutInMilliseconds = 100000;
      hubConnection.onclose((error) => print("Connection Closed"));
      await hubConnection.start();
        print(hubConnection.state);
        var nodeQueryResultSignalR = await hubConnection
            .invoke("GetListTagsWithJson", args: <String>[json.toString()]);
        print(nodeQueryResultSignalR);
        event.nodeQueryResultModel =
            NodeQueryResultModel.fromJson(nodeQueryResultSignalR);
        print(event.nodeQueryResultModel.deviceQueryResults.length);
      return emit(MachineDetailsStateDataUpdated(
          nodeQueryResultModel: event.nodeQueryResultModel));
    }
  }
}

 

