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
  List<DeviceQueryResult> deviceQueryResultList = [];
  DeviceQueryResult deviceQueryResult = DeviceQueryResult(
      deviceId: 'deviceId', connected: false, tagQueryResults: []);
  List<TagQueryResult> tagQueryResultList = [];
  TagQueryResult tagQueryResult = TagQueryResult(tagName: '', value: '');
  List<DeviceQueryResult> connectedDeviceQueryResult = [];
  NodeQueryResultModel nodeQueryResult = NodeQueryResultModel(
      connected: false, deviceQueryResults: [], eonNodeId: '');
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(text: "Tất cả"),
              //Tab(text: "Đang chạy"),
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
              Navigator.pushNamed(context, 'two');
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
                            style: TextStyle(color: Colors.white, fontSize: 25),
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
          } else if (machineDetailsState is MachineDetailsStateDataUpdated) {
            nodeQueryResult = machineDetailsState.nodeQueryResultModel;
          } else if (machineDetailsState is MachineDetailsStateInit) {
            
            } 
        }, builder: (context, machineDetailState) {
          if (machineDetailState is MachineDetailsStateDataUpdated
          ) {
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
                        Text('Mã máy: ${nodeQueryResult.deviceQueryResults[index].deviceId}'),
                        Expanded(
                          child: GestureDetector(
                            child: Image(
                              image: const AssetImage('lib/assets/may_ep.jpg'),
                              width: SizeConfig.screenWidth * 0.3650,
                            ),
                            onTap: () {
                              Global.deviceQueryResult = nodeQueryResult
                                  .deviceQueryResults[index];
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
                                  color: bool.fromEnvironment(
                                          nodeQueryResult
                                              .deviceQueryResults[index]
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
                // // machines connecting creen
                // GridView.builder(
                //   padding: const EdgeInsets.all(10),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisSpacing: SizeConfig.screenWidth * 0.0650,
                //     crossAxisCount: 2,
                //   ),
                //   itemCount: connectedDeviceQueryResult.length,
                //   itemBuilder: (context, index) {
                //     return Column(
                //       children: [
                //         Text(connectedDeviceQueryResult[index]
                //             .deviceId
                //             .toString()),
                //         Expanded(
                //           child: GestureDetector(
                //             child: Image(
                //               image: const AssetImage('lib/assets/may_ep.jpg'),
                //               width: SizeConfig.screenWidth * 0.3650,
                //             ),
                //             onTap: () {
                //               Navigator.of(context).push(MaterialPageRoute(
                //                   builder: (context) => MachineDetailsScreen(
                //                       connectedDeviceQueryResult[index])));
                //             },
                //           ),
                //         ),
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Icon(
                //               bool.fromEnvironment(
                //                       connectedDeviceQueryResult[index]
                //                           .connected
                //                           .toString())
                //                   ? Icons.check_box_rounded
                //                   : Icons.check_box_outline_blank_rounded,
                //               color: bool.fromEnvironment(
                //                       connectedDeviceQueryResult[index]
                //                           .connected
                //                           .toString())
                //                   ? Colors.green
                //                   : Colors.red,
                //               size: 20,
                //             ),
                //             const SizedBox(width: 10),
                //             Text(
                //               bool.fromEnvironment(
                //                       connectedDeviceQueryResult[index]
                //                           .connected
                //                           .toString())
                //                   ? "Đang kết nối"
                //                   : "Ngắt kết nối",
                //               style: TextStyle(
                //                   fontSize: 20,
                //                   color: bool.fromEnvironment(
                //                           connectedDeviceQueryResult[index]
                //                               .connected
                //                               .toString())
                //                       ? Colors.green
                //                       : Colors.red),
                //             ),
                //             const SizedBox(width: 20),
                //           ],
                //         ),
                //       ],
                //     );
                //   },
                // ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        }),
      ),
    );
  }
}
