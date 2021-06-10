import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/utility.dart';


abstract class AppStyles {


  static const BorderSide _customBorderSide =  BorderSide(width: 0.6, color:AppColors.PRIMARY_COLOR,);
  static const  BoxDecoration boxDecoration = const BoxDecoration(
    border: Border(
      bottom:_customBorderSide,
      top: _customBorderSide,
      left:_customBorderSide,
      right:_customBorderSide,
    ),
    borderRadius: BorderRadius.all( Radius.circular(5.0)),
    color: Colors.black,
    boxShadow: [
      BoxShadow(
        color:AppColors.PRIMARY_COLOR,
        blurRadius: 2.0,
        spreadRadius: 0.0,
        offset: Offset(2.0, 2.0), // shadow direction: bottom right
      )
    ],

  );




  static  Container goldenBorderBox({Widget child,double width=300 }) => Container(
    width: width,
    padding: EdgeInsets.all(12),
    margin: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5)),
     // color:AppColors.PRIMARY_COLOR
    ),
    child: child,
  );

  static const TextStyle whiteSmallText = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 14,
      height: 1,
      fontWeight: FontWeight.w600
  );



  static const TextStyle whiteBigText = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 17,
      height: 2,
      fontWeight: FontWeight.w900
  );


  static const TextStyle whiteLargeText = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.white,
      fontSize: 23,
      height: 2,
      fontWeight: FontWeight.bold
  );


  static const TextStyle goldenSmallText = TextStyle(
      fontFamily: 'Montserrat',
      color: AppColors.PRIMARY_COLOR,
      fontSize: 14,
      height: 2,
      fontWeight: FontWeight.w600,

  );

  static const TextStyle goldenBigText = TextStyle(
      fontFamily: 'Montserrat',
      color: AppColors.PRIMARY_COLOR,
      fontSize: 16,
      height: 2,
      fontWeight: FontWeight.w700
  );



  static InputDecoration textFieldStyle({String labelTextStr="",String hintTextStr=""})   =>  InputDecoration(
        contentPadding: EdgeInsets.all(12),
        labelText: labelTextStr,
        hintText:hintTextStr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );


}