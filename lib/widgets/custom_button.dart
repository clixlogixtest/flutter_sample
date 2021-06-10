import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/utility.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final MaterialColor color;


  CustomButton({
    @required this.text  ,
    this.color = Colors.green,
    this.onPressed = _onPressed //if no handler provided then call this fucntiona
  });


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: Utility.getDeviceWidth(context) * 0.9,
      child:  RawMaterialButton(
        fillColor:Colors.white,
        splashColor:Colors.blueGrey,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child:Text(text, maxLines: 1,style: TextStyle(color: AppColors.PRIMARY_COLOR,fontSize: 18,fontWeight: FontWeight.bold) ),
        ),
        onPressed: onPressed,
        shape: const StadiumBorder(),
      ),
    );
  }

  static dynamic _onPressed() {}
}



