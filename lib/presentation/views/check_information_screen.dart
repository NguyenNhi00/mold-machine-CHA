import 'package:flutter/material.dart';
import 'package:injection_molding_machine_application/presentation/widgets/constant.dart';
import 'package:injection_molding_machine_application/presentation/widgets/widgets.dart';
 class CheckInfomationView extends StatelessWidget {
   const CheckInfomationView({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     SizeConfig().init(context);
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
       children: [
         const Icon(Icons.sentiment_very_satisfied_rounded, size: 130,color: Constants.mainColor,),
         const Text('Tín hiệu gửi về máy chủ thành công', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
         SizedBox(
           height: SizeConfig.screenHeight * 0.0702,
         ),
         CustomizedButton(
              text: "TRỞ LẠI",
              fontSize: 20,
              width: SizeConfig.screenWidth * 0.6221,
              padding: 80,
              height: SizeConfig.screenHeight * 0.07121,
              onPressed: () {
                Navigator.pushNamed(context, '/MachineDetailsScreen');
              },
            ),
            SizedBox(height: SizeConfig.screenHeight * 0.0028),
       ],
     ),),);
   }
 }