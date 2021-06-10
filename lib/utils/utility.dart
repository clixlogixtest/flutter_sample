import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';



class Utility {

  //show message in application
  static void showMessage(String message,{bool error = true}){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
       // gravity: ToastGravity.BOTTOM,
        backgroundColor: error ? Colors.red : Colors.pinkAccent,
        textColor:  error ? Colors.white :Colors.white,
        fontSize: 16.0
    );
  }


  //get device width
  static double getDeviceWidth(BuildContext context){
    return MediaQuery.of(context).size.width;
  }

  //get device width
  static double getDeviceHeight(BuildContext context){
    return MediaQuery.of(context).size.height;
  }


  static void setStatusBar(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.white, // this one for android
        statusBarBrightness: Brightness.light// this one for iOS
    ));
  }


  //use of print the logs as print() truncate long text while test
  static void printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }


}
