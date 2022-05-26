
import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/presentation/views/check_information_screen.dart';

import 'constant.dart';

class ConfirmDialog {
  String text;
  BuildContext buildContext;
  ConfirmDialog( this.text,this.buildContext);
  void showMyAlertDialog(BuildContext context) {
    // bool tappedCancel = false;
    // creater a AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Container(
          height: 40,
          width: double.infinity,
          color: Constants.mainColor,
          child: const Center(
              child: Text(
            'KHUNG XÁC NHẬN',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ))),
      content: Text(
        "Bạn Có Chắc Chắn Muốn $text ?",
        style: const TextStyle(fontSize: 25, color: Constants.mainColor),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => const CheckInfomationView()));
              // Global.qcReport = QcReport(null,null,null, [], [], null);
          },
          child: Row(
            children:  [
               Container(
                 width: 160,
                 child: const Text(
                  'XÁC NHẬN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
               ),
              const SizedBox(width: 30,),
              const Icon(Icons.check, size: 30,color: Colors.green,)
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff001D37)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children:  [
               Container(
                 width: 190,
                 child: const Text(
                  'HỦY BỎ',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
               ),
              const Icon(Icons.cancel_presentation, size: 30,color: Colors.red,)
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
    );
    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    futureValue.then((value) {
      // ignore: avoid_print
      print("Return value: " + value.toString()); // true/false
    });
  }
}

class ConfirmDialogCondition {
  String text;
  BuildContext buildContext;
  ConfirmDialogCondition(this.text, this.buildContext);
  void showMyAlertDialog(BuildContext context) {
    // bool tappedCancel = false;
    // creater a AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Container(
          height: 40,
          width: double.infinity,
          color: Constants.mainColor,
          child: const Center(
              child: Text(
            'KHUNG XÁC NHẬN',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ))),
      content: Text(
        "Bạn Có Chắc Chắn Muốn $text ?",
        style: const TextStyle(fontSize: 25, color: Constants.secondaryColor),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
             Navigator.pushNamed(context, '/SendConditionCheckScreen');
            // Global.qcReport = QcReport(null,null,null, [], [], null);
          },
          child: Row(
            children: [
              Container(
                width: 160,
                child: const Text(
                  'XÁC NHẬN',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              )
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff001D37)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Row(
            children: [
              Container(
                width: 190,
                child: const Text(
                  'HỦY BỎ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const Icon(
                Icons.cancel_presentation,
                size: 30,
                color: Colors.red,
              )
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
    );
    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    futureValue.then((value) {
      // ignore: avoid_print
      print("Return value: " + value.toString()); // true/false
    });
  }
}

class NotificationDisconnectServer {
  BuildContext context;
  NotificationDisconnectServer(this.context);
  void showMyAlertDialog(BuildContext context) {
    // bool tappedCancel = false;
    // creater a AlertDialog
    AlertDialog dialog = AlertDialog(
      title: Container(
          height: 40,
          width: double.infinity,
          color: Constants.mainColor,
          child: const Center(
              child: Text(
            'THÔNG BÁO',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ))),
      content: const Text(
        "Mất kết nối đến máy chủ",
        style: TextStyle(fontSize: 25, color: Constants.secondaryColor),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              Container(
                width: 160,
                child: const Text(
                  'Đồng ý',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              const Icon(
                Icons.check,
                size: 30,
                color: Colors.green,
              )
            ],
          ),
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(const Color(0xff001D37)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
    );
    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    futureValue.then((value) {
      // ignore: avoid_print
      print("Return value: " + value.toString()); // true/false
    });
  }
}
