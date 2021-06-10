
import 'package:flutter/material.dart';
import 'package:slider_widget/utils/app_colors.dart';

class ProgressBar extends StatelessWidget {

  final Color color;
  //Indicator.ballPulse
  const ProgressBar({ Key key, this.color = Colors.transparent}) : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        color:  Colors.transparent,
        child: Center(
          child: CircularProgressIndicator(backgroundColor: Colors.red,),
        )
    );
  }
}