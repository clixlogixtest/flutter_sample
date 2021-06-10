import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/utility.dart';

class SocialButton extends StatelessWidget {
  final GestureTapCallback onPressed;
  final String text;
  final String image;


  SocialButton({
    @required this.text  ,
    this.image = '',
    this.onPressed = _onPressed //if no handler provided then call this fucntiona
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: Utility.getDeviceWidth(context) * 0.59,
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.BORDER_COLOR,width: 1),
            borderRadius: BorderRadius.all(
                Radius.circular(7.0) //
            ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(image,width: 25,height: 25,),
            SizedBox(width: 20,),
            Expanded(child: Text(text,style: TextStyle(fontFamily: 'SGIcons',fontSize: 14),))
          ],
        ),
      ),
    );
  }

  static dynamic _onPressed() {}
}



