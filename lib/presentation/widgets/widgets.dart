import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:in_app_notification/in_app_notification.dart';
import 'package:injection_molding_machine_application/domain/entities/supervision.dart';
import 'package:injection_molding_machine_application/presentation/widgets/global.dart';
import 'constant.dart';

class CustomizedButton extends StatelessWidget {
  String text;
  double padding;
  double width, height, radius;
  Color bgColor;
  Color fgColor;
  VoidCallback onPressed;
  double fontSize;
  CustomizedButton(
      {this.text = "Tên nút",
      this.width = 100,
      this.height = 50,
      this.padding = 20,
      this.radius = 20,
      this.bgColor = Constants.mainColor,
      this.fgColor = Colors.white,
      required this.onPressed,
      this.fontSize = 30});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: padding),
      child: Container(
        width: width,
        height: height,
        // ignore: deprecated_member_use
        child: RaisedButton(
          disabledColor: Colors.grey,
          color: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Text(
            text,
            style: TextStyle(
                fontSize: fontSize,
                color: fgColor,
                fontWeight: FontWeight.bold),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

class AnnotationContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [Column()],
      ),
    );
  }
}

class CircularLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 60,
              height: 60,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Constants.mainColor),
                strokeWidth: 6.0,
              )),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Đang tải dữ liệu",
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

class IconAnnotation extends StatelessWidget {
  final Color color;
  const IconAnnotation({this.color = Colors.blue});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 30,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(5)),
    );
  }
}

class TextAnnotation extends StatelessWidget {
  final String text;
  const TextAnnotation({required this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
    );
  }
}

class CustomCheckboxState1 extends StatefulWidget {
  String text;
  String machineId;
  CustomCheckboxState1(this.text, this.machineId);
  @override
  State<CustomCheckboxState1> createState() =>
      _CustomCheckboxState1State(text, machineId);
}

class _CustomCheckboxState1State extends State<CustomCheckboxState1> {
  ConditionCheck conditionCheck =
      ConditionCheck(checkPass: false, name: 'name');
  bool _checkpassed = false;
  String text;
  String machineId;
  _CustomCheckboxState1State(this.text, this.machineId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _checkpassed = !_checkpassed;
            if (_checkpassed == true) {
              Global.supervision.machineId = machineId;
              conditionCheck.name = text;
              conditionCheck.checkPass = _checkpassed;
              Global.supervision.conditionCheck!.add(conditionCheck);
              print(Global.supervision);
            }
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: Container(
            child: _checkpassed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            //padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
                color: _checkpassed ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: _checkpassed
                    ? Border.all(color: Colors.black, width: 2.0)
                    : Border.all(color: Colors.black, width: 2.0)),
            width: 25,
            height: 25,
          ),
        ));
  }
}

class CustomCheckboxState2 extends StatefulWidget {
  String text;
  String machineId;
  CustomCheckboxState2(this.text, this.machineId);
  @override
  State<CustomCheckboxState2> createState() =>
      _CustomCheckboxState2State(text, machineId);
}

class _CustomCheckboxState2State extends State<CustomCheckboxState2> {
  ConditionCheck conditionCheck =
      ConditionCheck(checkPass: false, name: 'name');
  bool _checkpassed = false;
  String text;
  String machineId;
  _CustomCheckboxState2State(this.text, this.machineId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _checkpassed = !_checkpassed;
            if (_checkpassed == true) {
              Global.supervision.machineId = machineId;
              conditionCheck.name = text;
              conditionCheck.checkPass = _checkpassed;
              Global.supervision.conditionCheck!.add(conditionCheck);
              print(Global.supervision);
            }
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: Container(
            child: _checkpassed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            //padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
                color: _checkpassed ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: _checkpassed
                    ? Border.all(color: Colors.black, width: 2.0)
                    : Border.all(color: Colors.black, width: 2.0)),
            width: 25,
            height: 25,
          ),
        ));
  }
}

class CustomCheckboxState3 extends StatefulWidget {
  String text;
  String machineId;
  CustomCheckboxState3(this.text, this.machineId);
  @override
  State<CustomCheckboxState3> createState() =>
      _CustomCheckboxState3State(text, machineId);
}

class _CustomCheckboxState3State extends State<CustomCheckboxState3> {
  ConditionCheck conditionCheck =
      ConditionCheck(checkPass: false, name: 'name');
  bool _checkpassed = false;
  String text;
  String machineId;
  _CustomCheckboxState3State(this.text, this.machineId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _checkpassed = !_checkpassed;
            if (_checkpassed == true) {
              Global.supervision.machineId = machineId;
              conditionCheck.name = text;
              conditionCheck.checkPass = _checkpassed;
              Global.supervision.conditionCheck!.add(conditionCheck);
              print(Global.supervision);
            }
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: Container(
            child: _checkpassed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            //padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
                color: _checkpassed ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: _checkpassed
                    ? Border.all(color: Colors.black, width: 2.0)
                    : Border.all(color: Colors.black, width: 2.0)),
            width: 25,
            height: 25,
          ),
        ));
  }
}

class CustomCheckboxState4 extends StatefulWidget {
  String text;
  String machineId;
  CustomCheckboxState4(this.text, this.machineId);
  @override
  State<CustomCheckboxState4> createState() =>
      _CustomCheckboxState4State(text, machineId);
}

class _CustomCheckboxState4State extends State<CustomCheckboxState4> {
  ConditionCheck conditionCheck =
      ConditionCheck(checkPass: false, name: 'name');
  bool _checkpassed = false;
  String text;
  String machineId;
  _CustomCheckboxState4State(this.text, this.machineId);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            _checkpassed = !_checkpassed;
            if (_checkpassed == true) {
              Global.supervision.machineId = machineId;
              conditionCheck.name = text;
              conditionCheck.checkPass = _checkpassed;
              Global.supervision.conditionCheck!.add(conditionCheck);
              print(Global.supervision);
            }
          });
        },
        child: Container(
          width: 50,
          height: 50,
          padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
          child: Container(
            child: _checkpassed
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
            //padding: EdgeInsets.only(left: 5.0),
            decoration: BoxDecoration(
                color: _checkpassed ? Colors.blue : Colors.transparent,
                borderRadius: BorderRadius.circular(25.0),
                border: _checkpassed
                    ? Border.all(color: Colors.black, width: 2.0)
                    : Border.all(color: Colors.black, width: 2.0)),
            width: 25,
            height: 25,
          ),
        ));
  }
}

class DialogBox extends StatelessWidget {
  const DialogBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Icon(Icons.check_box),
    );
  }
}

class NotificationBody extends StatelessWidget {
  final double minHeight;

  NotificationBody({
    Key? key,
    this.minHeight = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final minHeight = math.min(
      this.minHeight,
      MediaQuery.of(context).size.height,
    );
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minHeight),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 4, 16, 0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 12,
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 1.1,
                    color: Colors.lightBlueAccent.withOpacity(0.2),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const SizedBox(
                              width: 230,
                            ),
                            IconButton(
                                onPressed: () {
                                  InAppNotification.dismiss(context: context);
                                },
                                icon: const Icon(
                                  Icons.cancel_presentation_outlined,
                                  size: 40,
                                )),
                          ],
                        ),
                        const Icon(
                          Icons.cast_connected_outlined,
                          size: 100,
                          color: Constants.mainColor,
                        ),
                        Text(
                          'Đã kết nối tới máy chủ! ',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
