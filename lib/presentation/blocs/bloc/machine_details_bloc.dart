import 'dart:convert';
import 'dart:ffi';

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
      List<String> tagQuery = [
        'L6.CycleTime',
        'L6.OpenTime',
        'L6.CounterShot',
        'L6.SetCycle',
        'L6.MachineStatus'
      ];
      DeviceQuery deviceQuery = DeviceQuery(deviceId: 'l6', tagNames: tagQuery);
      List<DeviceQuery> deviceQueries = [deviceQuery];
      NodeQuery nodeQuery =
          NodeQuery(eonNodeId: 'imm', deviceQueries: deviceQueries);
      List deviceQueryJsons = [];
      // toJson
      for (int i = 0; i < deviceQueries.length; i++) {
        Map<String, dynamic> deviceQueryJson = {
          'DeviceId': deviceQueries[i].deviceId,
          'Tagnames': tagQuery,
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
      return emit(MachineDetailsStateDataUpdated(
          nodeQueryResultModel: event.nodeQueryResultModel));
    }
  }
}

  // @override
  // Stream<MachineDetailsState> mapEventToState(MachineEvent event) async* {
  //   if (event is MachineDetailsEventHubConnected) {
  //     emit(MachineDetailsStateLoadingRequest(timestamp: event.timestamp));
  //     event.hubConnection.state == HubConnectionState.disconnected
  //         ? await event.hubConnection.start()!.onError((error, stackTrace) {
  //             return MachineDetailsBloc().add(MachineDetailsEventConnectFail(
  //                 errorPackage: ErrorPackage(
  //                     errorCode: "error",
  //                     message: "Ngắt kết nối",
  //                     detail: "Đã ngắt kết nối tới máy chủ")));
  //           })
  //         : await event.hubConnection.stop();
  //     if (event.hubConnection.state == HubConnectionState.disconnected) {
  //       // print('Trạng thái hub:' + event.hubConnection.state.toString());
  //       emit(MachineDetailsStateConnectFail(
  //           errorPackage: ErrorPackage(
  //               errorCode: "error",
  //               message: "Ngắt kết nối",
  //               detail: "Đã ngắt kết nối tới máy chủ"))) ;
  //     } else if (event.hubConnection.state == HubConnectionState.connected) {
  //       // MoldMonitorModel moldMonitorModel = MoldMonitorModel(
  //       //   alarm: false,
  //       //   running: false,
  //       //   maSanPham: "M25",
  //       //   soLuongKeHoach: 0,
  //       //   soLuongThucTe: 0,
  //       // );
  //       // MoldModel moldModel = const MoldModel(
  //       //   id: "1234",
  //       //   standardInjectionCycle: 10,
  //       //   standardOpenTime: 10,
  //       //   injectionCycleTolerance: 5,
  //       //   automatic: true,
  //       //   productsPerShot: 0,
  //       // );
  //       yield MachineDetailsStateConnectSuccessful();
  //     }
  //   } else if (event is MachineDetailsEventDataUpDated) {
  //     // yield MachineDetailsStateDataUpdated(
  //     //   nodeQueryResult:event.nodeQueryResult,
  //     //   timestamp: DateTime.now(),
  //     // );
  //     emit(MachineDetailsStateDataUpdated(
  //         nodeQueryResult: event.nodeQueryResult, timestamp: DateTime.now()));
  //   } else if (event is MachineDetailsEventConnectFail) {
  //     emit(MachineDetailsStateConnectFail(
  //         errorPackage: ErrorPackage(
  //             errorCode: "error",
  //             message: "Ngắt kết nối",
  //             detail: "Đã ngắt kết nối tới máy chủ")));
  //   }
  // }

