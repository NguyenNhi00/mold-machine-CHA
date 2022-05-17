import 'package:flutter/material.dart';
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
      this.radius = 60,
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
            style: TextStyle(fontSize: fontSize, color: fgColor, fontWeight: FontWeight.bold),
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
  @override
  State<CustomCheckboxState1> createState() => _CustomCheckboxState1State();
}

class _CustomCheckboxState1State extends State<CustomCheckboxState1> {
   bool _checkpassed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: (){
         setState(() {
              _checkpassed = !_checkpassed;
         });
      },
        child: Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        child:_checkpassed ? const Icon(Icons.check, color: Colors.white,) : null ,
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
  @override
  State<CustomCheckboxState2> createState() => _CustomCheckboxState2State();
}

class _CustomCheckboxState2State extends State<CustomCheckboxState2> {
   bool _checkpassed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: (){
         setState(() {
             _checkpassed = !_checkpassed;
         });
      },
        child: Container(
          
      width: 50,
      height: 50,
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        child:_checkpassed ? const Icon(Icons.check, color: Colors.white,) : null ,
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
  @override
  State<CustomCheckboxState3> createState() => _CustomCheckboxState3State();
}

class _CustomCheckboxState3State extends State<CustomCheckboxState3> {
   bool _checkpassed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: (){
         setState(() {
              _checkpassed = !_checkpassed;
         });
      },
        child: Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
       child:_checkpassed ? const Icon(Icons.check, color: Colors.white,) : null ,
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
  @override
  State<CustomCheckboxState4> createState() => _CustomCheckboxState4State();
}

class _CustomCheckboxState4State extends State<CustomCheckboxState4> {
  bool _checkpassed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
         setState(() {
             _checkpassed = !_checkpassed;
         });
      },
        child: Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Container(
        child:_checkpassed ? const Icon(Icons.check, color: Colors.white,) : null ,
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
   const DialogBox({ Key? key }) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return Container(     
             child: const Icon(Icons.check_box),             
     );
   }
 }






