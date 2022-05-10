import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_molding_machine_application/data/models/error_package.dart';
import 'package:injection_molding_machine_application/data/models/node_query_results_model.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/machine_details_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/machine_details_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machine_details_state.dart';
import 'package:injection_molding_machine_application/presentation/views/machine_details_screen.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';
import 'package:signalr_core/signalr_core.dart';

class DeviceQueryResultView extends StatefulWidget {
  _DeviceQueryResultViewState createState() => _DeviceQueryResultViewState();
}

class _DeviceQueryResultViewState extends State<DeviceQueryResultView> {
  late HubConnection hubConnection;
  List<DeviceQueryResult> connectedDeviceQueryResult = [];
  NodeQueryResult nodeQueryResult = const NodeQueryResult(
      connected: false, deviceQueryResults: [], eonNodeId: '');
  String deviceId = ''; // ma may
  String data1 = "null"; // ma san pham
  String data2 = "null"; // so luong ke hoach
  String data3 = "null"; // so luong thuc te
  String data4 = "CycleTime";
  String data5 = "OpenTime";
  String data6 = "CounterShot";
  String data7 = "SetCycle";
  String data8 = "MachineStatus";
  bool warning = false;
  bool running = false;
  @override
  void initState() {
    super.initState();
    try {
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
      hubConnection.start()!.then((nodeQueryResultSignalR) async {
        if (hubConnection.state == HubConnectionState.connected) {
          final nodeQueryResultSignalR =
              await hubConnection.invoke("GetListTags", args: <Object>[json]);
          dynamic data = jsonDecode(nodeQueryResultSignalR);
          NodeQueryResultModel nodeQueryResultFromJson =
              NodeQueryResultModel.fromJson(data);
          nodeQueryResult = nodeQueryResultFromJson;
          print(nodeQueryResult);
        }
      });
      for (int i = 0; i < nodeQueryResult.deviceQueryResults.length; i++) {
        if (nodeQueryResult
                    .deviceQueryResults[i].tagQueryResults[4].value ==
                1 ||
            nodeQueryResult.deviceQueryResults[i].tagQueryResults[4].value ==
                2 ||
            nodeQueryResult.deviceQueryResults[i].tagQueryResults[4].value ==
                3) {
          connectedDeviceQueryResult.add(nodeQueryResult.deviceQueryResults[i]);
        }
      }
      BlocProvider.of<MachineDetailsBloc>(context).add(
          MachineDetailsEventDataUpDated(
              timestamp: DateTime.now(), nodeQueryResult: nodeQueryResult));
    } on TimeoutException {
      BlocProvider.of<MachineDetailsBloc>(context).add(
          MachineDetailsEventConnectFail(
              errorPackage: ErrorPackage(
                  errorCode: "erro",
                  message: "Không tìm thấy máy chủ",
                  detail: "Vui lòng kiểm tra đường truyền!")));
    } on SocketException {
      BlocProvider.of<MachineDetailsBloc>(context).add(
          MachineDetailsEventConnectFail(
              errorPackage: ErrorPackage(
                  errorCode: "erro",
                  message: "Không tìm thấy máy chủ",
                  detail: "Vui lòng kiểm tra đường truyền!")));
    } catch (e) {
      print(e);
      BlocProvider.of<MachineDetailsBloc>(context).add(
          MachineDetailsEventConnectFail(
              errorPackage: ErrorPackage(
                  errorCode: "error",
                  message: "Lỗi xảy ra",
                  detail: e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: "Tất cả"),
                Tab(text: "Đang chạy"),
              ],
            ),
            title: const Text('Quản lý máy ép'),
            backgroundColor: Constants.mainColor,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
            ),
          ),
          endDrawer: Drawer(
            backgroundColor: Constants.secondaryColor,
            child: Column(
              children: [
                Container(
                  width: SizeConfig.screenWidth * 0.7421,
                  height: SizeConfig.screenHeight * 0.4659,
                  decoration: const BoxDecoration(
                      color: Constants.mainColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(35.0),
                          bottomRight: Radius.circular(35.0))),
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0664,
                      ),
                      Icon(
                        Icons.account_circle_rounded,
                        size: SizeConfig.screenHeight * 0.2659,
                        color: Colors.white,
                      ),
                      const Text(
                        'Người Kiểm Tra:',
                        style: TextStyle(fontSize: 23, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.screenWidth * 0.0468,
                          top: SizeConfig.screenHeight * 0.0797),
                      child: Row(
                        children: [
                          Icon(
                            Icons.settings_outlined,
                            size: SizeConfig.screenHeight * 0.0398,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.0156,
                          ),
                          const Text(
                            'Cài Đặt',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.screenHeight * 0.0398,
                    ),
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.screenWidth * 0.0468),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              size: SizeConfig.screenHeight * 0.0398,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: SizeConfig.screenWidth * 0.0156,
                            ),
                            const Text(
                              'Đăng Xuất',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.popAndPushNamed(context, '/');
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
          body: BlocConsumer<MachineDetailsBloc, MachineDetailsState>(
              listener: (context, machineDetailsState) async {
            if (machineDetailsState is MachineDetailsStateConnectSuccessful) {
            } else if (machineDetailsState is MachineDetailsStateDataUpdated) {}
          }, builder: (context, machineDetailState) {
            if (machineDetailState is MachineDetailsStateDataUpdated) {
              return TabBarView(
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: SizeConfig.screenWidth * 0.0650,
                      crossAxisCount: 2,
                    ),
                    itemCount: nodeQueryResult.deviceQueryResults.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(nodeQueryResult
                              .deviceQueryResults[index].deviceId
                              .toString()),
                          Expanded(
                            child: GestureDetector(
                              child: Image(
                                image:
                                    const AssetImage('lib/assets/may_ep.jpg'),
                                width: SizeConfig.screenWidth * 0.3650,
                              ),
                              onTap: () {
                                Global.deviceQueryResult =
                                    nodeQueryResult.deviceQueryResults[index];
                                Navigator.pushNamed(
                                    context, '/MachineDetailsScreen');
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bool.fromEnvironment(nodeQueryResult
                                        .deviceQueryResults[index].connected
                                        .toString())
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                color: bool.fromEnvironment(nodeQueryResult
                                        .deviceQueryResults[index].connected
                                        .toString())
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                bool.fromEnvironment(nodeQueryResult
                                        .deviceQueryResults[index].connected
                                        .toString())
                                    ? "Đang kết nối"
                                    : "Ngắt kết nối",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: bool.fromEnvironment(nodeQueryResult
                                            .deviceQueryResults[index].connected
                                            .toString())
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  // machines connecting creen
                  GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: SizeConfig.screenWidth * 0.0650,
                      crossAxisCount: 2,
                    ),
                    itemCount: connectedDeviceQueryResult.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Text(connectedDeviceQueryResult[index]
                              .deviceId
                              .toString()),
                          Expanded(
                            child: GestureDetector(
                              child: Image(
                                image:
                                    const AssetImage('lib/assets/may_ep.jpg'),
                                width: SizeConfig.screenWidth * 0.3650,
                              ),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => MachineDetailsScreen(
                                        connectedDeviceQueryResult[index])));
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bool.fromEnvironment(
                                        connectedDeviceQueryResult[index]
                                            .connected
                                            .toString())
                                    ? Icons.check_box_rounded
                                    : Icons.check_box_outline_blank_rounded,
                                color: bool.fromEnvironment(
                                        connectedDeviceQueryResult[index]
                                            .connected
                                            .toString())
                                    ? Colors.green
                                    : Colors.red,
                                size: 20,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                bool.fromEnvironment(
                                        connectedDeviceQueryResult[index]
                                            .connected
                                            .toString())
                                    ? "Đang kết nối"
                                    : "Ngắt kết nối",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: bool.fromEnvironment(
                                            connectedDeviceQueryResult[index]
                                                .connected
                                                .toString())
                                        ? Colors.green
                                        : Colors.red),
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ));
  }
}
