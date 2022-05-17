import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/widgets/widgets.dart';

class SupervisionScreen extends StatelessWidget {
  const SupervisionScreen({ Key? key }) : super(key: key);

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
        body:  Center(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight*0.1,),
              const Text('THÔNG TIN GIÁM SÁT',style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Constants.mainColor)),
              SizedBox(height: SizeConfig.screenHeight*0.05,),
              Container(
                margin: EdgeInsets.all(20),
                              width: 400,
                              height: 300,
                              decoration: BoxDecoration(border: Border.all()),
                              padding: EdgeInsets.only(top: 50, left: 30),
                              child: Column(children: [
              Row(children:  [
                Container(
                  width: 250,
  
                  child: Text("Thông số cài đặt máy ép",style: TextStyle(fontSize: 15),)),
                CustomCheckboxState1()
              ],),
               Row(children: [
                Container(
                  width: 250,
                  child: const Text("Quy trình hoạt động máy ép",style: TextStyle(fontSize: 15),)),
                CustomCheckboxState2()
              ],),
               Row(children:  [
                Container(
                  width: 250,
                  child: const Text("Nhân công đứng máy",style: TextStyle(fontSize: 15),)),
                CustomCheckboxState3()
              ],),
              Row(children: [
                Container(
                  width: 250,
                  child: const Text("Nhiệt độ môi trường",style: TextStyle(fontSize: 15),)),
                CustomCheckboxState4()
              ],)
      ],),
                            ),
            ],
          ),
        ),);
  }
}