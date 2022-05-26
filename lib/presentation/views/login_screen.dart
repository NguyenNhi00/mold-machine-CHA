
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/bloc/login_bloc.dart';
import 'package:injection_molding_machine_application/presentation/blocs/event/login_event.dart';
import 'package:injection_molding_machine_application/presentation/blocs/state/login_state.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/widgets/password_preferences.dart';
import 'package:injection_molding_machine_application/presentation/widgets/username_preferences.dart';
import 'package:injection_molding_machine_application/presentation/widgets/widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordErr = false;
  bool _userErr = false;
  bool _isShow = true;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  void initState() {
    super.initState();
    userController.text = UsernamePreferences.getUsername() ?? '';
    passController.text = PasswordPreferences.getPassword() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'ĐĂNG NHẬP',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Constants.mainColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            tooltip: 'nut tro ve',
            iconSize: 24.0,
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
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0))),
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
                      style: TextStyle(fontSize:17 , color: Colors.white),
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
               
                ],
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, loginstate) async {
              if (loginstate is LoginStateLoginSuccessful) {
              }
              // else if(loginstate is LoginDoneState){
              //   loadingDialog.dismiss();
              //}
              else if (loginstate is LoginStateFormatChecking) {
                _passwordErr = loginstate.isPasswordErr;
                _userErr = loginstate.isUsernameErr;
              } else if (loginstate is LoginStateToggleShow) {
                _isShow = !loginstate.isShow;
              } else if (loginstate is LoginStateLoginSuccessful) {
                await UsernamePreferences.setUsername(userController.text);
                await PasswordPreferences.setPassword(passController.text);
                // ignore: unused_local_variable
                String? employeeIdoverrall =
                    loginstate.user.employee?.employeeId;
                // ignore: unused_local_variable
                String? employeeFirstnameoverrall =
                    loginstate.user.employee?.firstname;
                // ignore: unused_local_variable
                String? employeeLastnameoverrall =
                    loginstate.user.employee?.lastname;
                // Navigator.popAndPushNamed(context, '/third', arguments: {
                //   'Id': employeeIdoverrall.toString(),
                //   'Firstname': employeeFirstnameoverrall.toString(),
                //   'Lastname': employeeLastnameoverrall.toString(),
                // }
                // );
              }
            },
            builder: (context, loginState) {
              SizeConfig().init(context);
              return Column(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                        left: SizeConfig.screenWidth * 0.0781,
                        right: SizeConfig.screenWidth * 0.0781),
                    children: <Widget>[
                      SizedBox(height: SizeConfig.screenHeight * 0.0356),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image(
                          //   image: const AssetImage(
                          //       'lib/assets/logohunganh_1.jpg'),
                          //   width: SizeConfig.screenWidth * 0.2360,
                          // ),
                          // SizedBox(
                          //   width: SizeConfig.screenWidth * 0.0524,
                          // ),
                          Image(
                            image: const AssetImage('lib/assets/logo_bachkhoa-nobackgr.png'),
                            width: SizeConfig.screenWidth * 0.4560,
                          )
                        ],
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.05761),
                      TextField(
                        controller: userController,
                        decoration: InputDecoration(
                        prefixIcon: const Padding(
                            padding:
                                EdgeInsets.only(), // add padding to adjust icon
                            child: Icon(
                              Icons.assignment_ind_outlined,
                              size: 20,
                            ),
                          ),
                          hintText: 'Tên Đăng Nhập',
                          hintStyle: const TextStyle(fontSize: 18),
                          errorText: _userErr
                              ? 'Tên Đăng Nhập Phải Dài Hơn 3 Ký Tự'
                              : null,
                          errorStyle: const TextStyle(
                            color: Colors.red,
                            fontSize: 15,
                          ),
                          contentPadding:
                              const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.grey, width: 2),
                            gapPadding: 15,
                          ),
                        ),
                        onChanged: (_) {
                          BlocProvider.of<LoginBloc>(context).add(
                              LoginEventChecking(
                                  userController.text, passController.text));
                        },
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.03761),
                      Stack(alignment: AlignmentDirectional.topEnd, children: [
                        TextFormField(
                          obscureText: _isShow,
                          controller: passController,
                          decoration: InputDecoration(
                            prefixIcon: const Padding(
                              padding: EdgeInsets
                                  .only(), // add padding to adjust icon
                              child: Icon(
                                Icons.password_rounded,
                                size: 20,
                              ),
                            ),
                            hintText: 'Mật Khẩu',
                            hintStyle: const TextStyle(fontSize: 18),
                            errorText: _userErr
                                ? 'Mật Khẩu Phải Dài Hơn 6 Ký Tự'
                                : null,
                            errorStyle: const TextStyle(
                              color: Colors.red,
                              fontSize: 15,
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                20.0, 10.0, 20.0, 10.0),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                    const BorderSide(color: Colors.grey)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 2),
                              gapPadding: 15,
                            ),
                          ),
                          onChanged: (_) {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginEventChecking(
                                    userController.text, passController.text));
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            BlocProvider.of<LoginBloc>(context)
                                .add(LoginEventToggleShow(_isShow));
                          },
                          icon: Icon(
                            _isShow ? Icons.visibility_off : Icons.visibility,
                            color: Constants.mainColor,
                          ),
                        )
                      ]),
                      SizedBox(
                        height: SizeConfig.screenHeight * 0.0637,
                      ),
                      CustomizedButton(
              text: "ĐĂNG NHẬP",
              fontSize: 20,
              width: SizeConfig.screenWidth * 0.8521,
              padding: 10,
              height: SizeConfig.screenHeight * 0.07121,
              onPressed: () {
                Navigator.pushNamed(context, '/DeviceQueryResultView');
              },
            ),
                    ],
                  )
                ],
              );
            },
          ),
        ));
  }
}
