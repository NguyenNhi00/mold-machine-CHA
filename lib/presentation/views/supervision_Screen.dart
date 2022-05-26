import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/send_condition_check.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/send_condition_check_state.dart';
import 'package:injection_molding_machine_application/presentation/views/send_condition_check_screen.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/widgets/dialog.dart';
import 'package:injection_molding_machine_application/presentation/widgets/widgets.dart';

class SupervisionScreen extends StatelessWidget {
  String text1 = "Thông số cài đặt máy ép";
  String text2 = "Quy trình hoạt động máy ép";
  String text3 = "Nhân công đứng máy";
  String text4 = "Nhiệt độ môi trường";
  String machineId;
  SupervisionScreen(this.machineId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GIÁM SÁT QUY TRÌNH'),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
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
                      'Người Kiểm Tra: nhi0201',
                      style: TextStyle(fontSize: 17, color: Colors.white),
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
                            Icons.contact_page_sharp,
                            size: SizeConfig.screenHeight * 0.0398,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.0156,
                          ),
                          const Text(
                            'Quản Lý Máy Ép',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, '/DeviceQueryResultView');
                    },
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
                            Icons.pending_actions_outlined,
                            size: SizeConfig.screenHeight * 0.0398,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.0156,
                          ),
                          const Text(
                            'Thông Số Máy Ép',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, '/MachineDetailsScreen');
                    },
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
        body: BlocConsumer<SendConditionCheckBloc, SendConditionCheckState>(
          listener: (context, state) {
            if (state is SendConditionCheckDoneState) {}
          },
          builder: (context, state) {
            ConfirmDialogCondition confirmDialogCondition =
                ConfirmDialogCondition('Xác Nhận', context);
            if (state is SendConditionCheckDoneState) {
              return SendConditionCheckScreen();
            }
            if (state is IntState) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.1,
                      ),
                      const Text('THÔNG TIN GIÁM SÁT',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Constants.mainColor)),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.05,
                      ),
                      Container(
                        margin: const EdgeInsets.all(20),
                        width: 400,
                        height: 300,
                        decoration: BoxDecoration(border: Border.all()),
                        padding: const EdgeInsets.only(top: 50, left: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(
                                      "$text1",
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                CustomCheckboxState1(text1, machineId)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(
                                      "$text2",
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                CustomCheckboxState2(text2, machineId)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(
                                      "$text3",
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                CustomCheckboxState3(text3, machineId)
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 200,
                                    child: Text(
                                      "$text4",
                                      style: const TextStyle(fontSize: 15),
                                    )),
                                CustomCheckboxState4(text4, machineId)
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Constants.mainColor)),
                            onPressed: () {
                              confirmDialogCondition.showMyAlertDialog(context);
                              // BlocProvider.of<SendConditionCheckBloc>(context)
                              //     .add(ConfirmSendConditionCheckevent());
                            },
                            child: const Text(
                              'XÁC NHẬN',
                              style: TextStyle(fontSize: 30),
                            )),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}
