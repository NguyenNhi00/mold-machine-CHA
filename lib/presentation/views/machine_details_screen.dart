import 'dart:async';
import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/domain/entities/configuration.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query.dart';
import 'package:injection_molding_machine_application/domain/entities/node_query_result.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/machine_management_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/machines_management_event.dart';
import 'package:injection_molding_machine_application/presentation/views/models/operating_params_reliability.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/views/models/mold_params_reliability.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
import '../../data/models/error_package.dart';
import '../blocs/bloc/machine_details_bloc.dart';
import '../blocs/event/machine_details_event.dart';
import '../widgets/widgets.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MachineDetailsScreen extends StatefulWidget {
  DeviceQueryResult deviceQueryResult;
  MachineDetailsScreen(this.deviceQueryResult);
  @override
  _MachineDetailsScreenState createState() =>
      _MachineDetailsScreenState(deviceQueryResult);
}

class _MachineDetailsScreenState extends State<MachineDetailsScreen> {
  DeviceQueryResult deviceQueryResult;
  _MachineDetailsScreenState(this.deviceQueryResult);
  String data1 = "null";
  String data2 = "null";
  String data3 = "null";
  String data4 = "null";
  String data5 = "null";
  String data6 = "null";
  String data7 = "null";
  String data8 = "null";
  bool warning = false;
  bool running = false;
  final _channel = WebSocketChannel.connect(Uri.parse(Constants.signalRUrl));
  late HubConnection hubConnection;
  List<Configuration> configuration = [];
  Product product = Product();
  @override
  void initState() {
    super.initState();
    try {
      hubConnection = HubConnectionBuilder()
          .withUrl(Constants.signalRUrl)
          .withAutomaticReconnect()
          .build();
      hubConnection.keepAliveIntervalInMilliseconds = 10000;
      hubConnection.serverTimeoutInMilliseconds = 10000;
      hubConnection.onclose((error) {
        return error != null
            ? BlocProvider.of<MachineDetailsBloc>(context).add(
                MachineDetailsEventConnectFail(
                    errorPackage: ErrorPackage(
                        errorCode: "error",
                        message: "Ngắt kết nối",
                        detail: "Đã ngắt kết nối đến máy chủ!")))
            : null;
      });
      hubConnection.on("machineDetailsHandlers", machineDetailsHandlers);
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
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thông số máy ép'),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/DeviceQueryResultView');
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
        body: BlocConsumer<MachinesManagementBloc, MachineManagementState>(
          listener: (context, MachineManagementState state) {
            if (state is MachineManagementStateLoaded) {
              product = state.product;
              print('information: $product');
            }
          },
          builder: (context, MachineDetailsState) {
            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: SizeConfig.screenHeight * 0.0256),
                    const Text(
                      'THÔNG SỐ VẬN HÀNH',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0128),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            right: 5,
                          ),
                          child: CustomizedButton(
                              text: "Tạm dừng",
                              fontSize: 15,
                              width: SizeConfig.screenWidth * 0.3121,
                              height: SizeConfig.screenHeight * 0.07121,
                              onPressed: () {
                                bool disconnectMachine = bool.fromEnvironment(
                                    deviceQueryResult.connected.toString()) ==
                                    false;
                                _channel.sink.add(
                                    "Tạm dừng máy ${deviceQueryResult.deviceId}");
                                _channel.sink.close(status.goingAway);
                              }),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                            left: 5,
                          ),
                          child: CustomizedButton(
                              text: "Tiếp tục",
                              fontSize: 15,
                              width: SizeConfig.screenWidth * 0.3121,
                              height: SizeConfig.screenHeight * 0.07121,
                              onPressed: () {
                                bool connectMachine = bool.fromEnvironment(
                                        deviceQueryResult.connected.toString()) ==
                                    true;
                                _channel.sink.add(connectMachine);
                                _channel.sink.close(status.goingAway);
                              }),
                        )
                      ],
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0128),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: SizeConfig.screenWidth * 0.8992,
                      height: SizeConfig.screenHeight * 0.1561,
                      child: MonitorOperatingParamsReli(
                        text1: "Mã sản phẩm",
                        text2: "Số lượng kế hoạch",
                        text3: "Số lượng thực tế",
                        data1: product.id.toString(),
                        data2: '',
                        data3: '',
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0256),
                    const Text(
                      'THÔNG SỐ KHUÔN',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0128),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: SizeConfig.screenWidth * 0.8992,
                      height: SizeConfig.screenHeight * 0.2461,
                      child: MoldParamsReli(
                        text4: "Mã số khuôn",
                        text5: "Chu kỳ ép",
                        text6: "Thời gian mở cửa",
                        text7: "Chế độ vận hành",
                        text8: "Số sản phẩm/lần ép",
                        data4: product.mold!.id.toString(),
                        data5: deviceQueryResult.tagQueryResults[0].value.toString(),
                        data6: deviceQueryResult.tagQueryResults[1].value.toString(),
                        data7: deviceQueryResult.tagQueryResults[4].value.toString(),
                        data8: deviceQueryResult.tagQueryResults[2].value.toString(),
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0256),
                    const Text(
                      'BẢNG GIÁM SÁT',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.0356),
                    Container(
                      decoration: BoxDecoration(border: Border.all()),
                      width: SizeConfig.screenWidth * 0.8992,
                      height: SizeConfig.screenHeight * 0.1996,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: SizeConfig.screenHeight * 0.1230,
                                height: SizeConfig.screenHeight * 0.1230,
                                decoration: BoxDecoration(
                                  color: 
                                    (deviceQueryResult.tagQueryResults[4].value == 1
                                    ||deviceQueryResult.tagQueryResults[4].value == 2
                                    ||deviceQueryResult.tagQueryResults[4].value == 3
                                    )
                                      ? Colors.green
                                      : Colors.black26,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                "ĐANG CHẠY",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: SizeConfig.screenHeight * 0.1230,
                                height: SizeConfig.screenHeight * 0.1230,
                                decoration: BoxDecoration(
                                  color: warning ? Colors.red : Colors.black26,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const Text(
                                "CẢNH BÁO",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }

  void machineDetailsHandlers(List<dynamic>? data) {}
}
