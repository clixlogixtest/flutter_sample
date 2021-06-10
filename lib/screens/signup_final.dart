import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slider_widget/blocs/signup/bloc.dart';
import 'package:slider_widget/blocs/signup/signup_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';




class SignUpFinal extends StatefulWidget {
  SignUpFinal({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpFinal>{


  SignUpBloc _signUpBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState()  {
    super.initState();
    //rest code here
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

  }

  @override
  void dispose() {
    //rest code here
    _signUpBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.welcome,style: TextStyle(fontFamily: 'SGIcons')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body:   BlocListener<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              Utility.showMessage(state.error,error: true);
              Navigator.of(context).pop();
            }

          },
          child: _authForm(),
        )

    );
  }

  Widget _authForm() => Stack(
    fit: StackFit.expand,
    children: [
      _SignUpForm(),
      BlocBuilder<SignUpBloc,SignUpState>(
        builder: (context, state) {
          if (state is SignUpLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );




}


class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {


  SignUpBloc _signUpBloc;

  @override
  void initState()  {
    super.initState();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);

  }



  @override
  void dispose() {
    _signUpBloc.close();
    super.dispose();
  }


  var titleText = new RichText(
    text: new TextSpan(
      // Note: Styles for TextSpans must be explicitly defined.
      // Child text spans will inherit styles from parent
      style: new TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      children: <TextSpan>[
        new TextSpan(text: Strings.welcomeTo,style: TextStyle(fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.sirius, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22,fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.geography,style: TextStyle(fontFamily: 'SGIcons')),
      ],
    ),
  );








  @override
  Widget build(BuildContext context) {

    final arguments = ModalRoute.of(context).settings.arguments as Map;

    _onFinalButtonPressed() {
      _signUpBloc.add(SignUpSubmitFinal(id: arguments['id'].toString(),
      name:arguments['name'],
      email: arguments['email'],
      token: arguments['token'])
      );

    }


    var bottomText =new Text(Strings.weHaveSentEmailTo,
      style: new TextStyle(
        fontSize: 14.0,
        color: AppColors.BLACK_TEXT_COLOR,
        fontWeight: FontWeight.w400,
        fontFamily: "SGIcons"
      ),
      textAlign: TextAlign.center,
    );

    var bottomContainer = new Container(
      width: MediaQuery.of(context).size.width * 0.63,
      height: 45,
      child:Center(child: Text(Strings.changeDisplayName.toUpperCase(),style: TextStyle(color: AppColors.PRIMARY_COLOR ,fontSize: 16,
          fontWeight: FontWeight.w600,fontFamily: "SGIcons"),),),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.PRIMARY_COLOR ,
          width: 2.0 ,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );



    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpError) {
          // _showError(state.error);
        }
        if (state is SignUpFinalSuccess){
          Navigator.pushNamed(context,'/home');
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: Utility.getDeviceHeight(context) * 0.34,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Image.asset(AssetManager.earth.value,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.contain,
                          height: 140
                      ),
                      Flexible(
                        child: titleText,
                      )
                    ],
                  ),
                ),
                Container(
                   //height: Utility.getDeviceHeight(context) * 0.62,
                  padding: EdgeInsets.fromLTRB(20, 55, 20, 30),
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    color: Colors.white,

                  ),
                  child: Column(
                    children: [

                      Text(Strings.yaySignedUp,style: TextStyle(fontSize: 21,fontWeight: FontWeight.w600,fontFamily: "SGIcons"),),

                      const SizedBox(
                        height: 20,
                      ),

                      Text(
                        "${Strings.email}:",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: "SGIcons"),),
                      if (arguments != null)  Text(arguments['email'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: "SGIcons",color:AppColors.BLACK_TEXT_COLOR),),


                      const SizedBox(
                        height: 20,
                      ),

                      Text( "${Strings.name}:",style: TextStyle(color: Colors.grey,fontFamily: "SGIcons",fontSize: 12),),
                      if (arguments != null)  Text(arguments['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: "SGIcons",color:AppColors.BLACK_TEXT_COLOR),),

                      const SizedBox(
                        height: 20,
                      ),
                      bottomContainer,


                      const SizedBox(
                        height: 20,
                      ),
                      bottomText,
                      const SizedBox(
                        height: 80,
                      ),


                      SizedBox(
                        width: Utility.getDeviceWidth(context) * 0.6,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [AppColors.GREEN_GRAD_ONE, AppColors.GREEN_GRAD_TWO]),
                              borderRadius:  BorderRadius.circular(10.0)
                          ),
                          child: ElevatedButton(
                            child: Text(Strings.getStarted.toUpperCase(),style: TextStyle(fontSize: 16,fontFamily: "SGIcons",color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary:Colors.transparent,
                                shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.transparent)
                                )
                            ),
                            onPressed: _onFinalButtonPressed,

                          ),
                        ),
                      ),



                      const SizedBox(
                        height: 26,
                      ),
                      const SizedBox(
                        height: 26,
                      ),





                    ],
                  ),
                )


              ],
            ),
          );
        },
      ),
    );
  }


}
