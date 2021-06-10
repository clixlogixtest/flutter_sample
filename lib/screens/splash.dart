import 'dart:async';

import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/assets.dart';
import 'package:flutter/material.dart';
import '../utils/storage_helper.dart';


class SplashScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SplashScreen> {

  void navigationPage() async{
    String id = await MySharedPreferences.instance.getStringValue('id');
    print('id is ' + id.toString());
    if(id.isEmpty) Navigator.pushReplacementNamed(context, '/login');
    else  Navigator.pushReplacementNamed(context, '/home');
  }


  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }


  @override
  void initState() {
    super.initState();
    startTime();

  }
  Widget logoPhoto() => Container(
    height: 300,
    margin: EdgeInsets.only(left: 20, right: 20),
    width: MediaQuery.of(context).size.width,
    child: Image.asset(AssetManager.earth.value,
      width: MediaQuery.of(context).size.width * 0.1,
      fit: BoxFit.contain,
      height: 70,),
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.black,
        body: Container(
          height: 1000,
          color: AppColor.black,
          child: Center(
            child: logoPhoto(),
           // child: Container(),
          ),
        ));
    ;
  }
}

/**
 *  List.generate(6, (index) {
    return Center(
    child: RaisedButton(
    onPressed: (){},
    color: Colors.greenAccent,
    child: Text(
    '$index AM',
    ),
    ),
    );
    })
 */
