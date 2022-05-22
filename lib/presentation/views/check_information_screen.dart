import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
 class CheckInfomationView extends StatelessWidget {
   const CheckInfomationView({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(appBar: AppBar(
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
     body: Container(
       padding: const EdgeInsets.only(top: 200),
       alignment: Alignment.center,
     child: Column(
       children: const [
         Icon(Icons.check_box, size: 150,color: Constants.mainColor,),
         Text('Tín hiệu gửi về máy chủ thành công', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
       ],
     ),),);
   }
 }