import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slider_widget/blocs/forgot_password/bloc.dart';
import 'package:slider_widget/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/forgot_password_validation.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';



class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword>{


  ForgotPasswordBloc _forgotPasswordBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState()  {
    super.initState();
    //rest code here
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);

  }

  @override
  void dispose() {
    //rest code here
    _forgotPasswordBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.forgotPassword,style: TextStyle(fontFamily: 'SGIcons')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body:   BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
          listener: (context, state) {
            if (state is ForgotPasswordError) {
              Utility.showMessage(state.error,error: true);
              //Navigator.pushNamed(context,'/home');
            }

          },
          child: _authForm(),
        )

    );
  }

  Widget _authForm() => Stack(
    fit: StackFit.expand,
    children: [
      _wrapNotifier(),
       BlocBuilder<ForgotPasswordBloc,ForgotPasswordState>(
        builder: (context, state) {
          if (state is ForgotPasswordLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );

  Widget _wrapNotifier() => ChangeNotifierProvider<ForgotPasswordValidation>(
        create: (_) => ForgotPasswordValidation(),
        child: new _ForgotPasswordForm(),
  );


}


class _ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {

  final _emailController = TextEditingController();
  ForgotPasswordBloc _forgotPasswordBloc;

  @override
  void initState()  {
    super.initState();
    _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);

  }

  @override
  void dispose() {
    _forgotPasswordBloc.close();
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
        new TextSpan(text: Strings.welcomeBackTo),
        new TextSpan(text: Strings.sirius, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22)),
        new TextSpan(text: Strings.geography)
      ],
    ),
  );


  var headingText = new Text(Strings.forgotPassword, style: new TextStyle(
    fontSize: 25.0,
    color: Colors.black,
    fontWeight: FontWeight.w600,fontFamily: 'SGIcons'
  ));

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
    width: 220,
    height: 40,
    child:Center(child: Text(Strings.keepPlaying.toUpperCase(),style: TextStyle(color:AppColors.PRIMARY_COLOR,
        fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SGIcons'),),),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: AppColors.PRIMARY_COLOR ,
        width: 2.0 ,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );



  var bottomButton = new Container(
    width: 220,
    height: 40,
    child:Center(child: Text(Strings.resetPassword.toUpperCase(),style: TextStyle(color:AppColors.PRIMARY_COLOR,
        fontSize: 16,fontWeight: FontWeight.w600,fontFamily: 'SGIcons'),),),
    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(
        color: AppColors.PRIMARY_COLOR ,
        width: 2.0 ,
      ),
      borderRadius: BorderRadius.circular(10),
    ),
  );



  @override
  Widget build(BuildContext context) {

    final _forgotPasswordBloc = BlocProvider.of<ForgotPasswordBloc>(context);
    final validationService = Provider.of<ForgotPasswordValidation>(context);

    _onResetButtonPressed() {
      FocusScope.of(context).requestFocus(FocusNode());
      _forgotPasswordBloc.add(ForgotPasswordSubmit(email: _emailController.text));

    }



    return BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state is ForgotPasswordError) {
          // _showError(state.error);
      }
        if (state is ForgotPasswordSuccess){
          // Utility.showMessage('Done Successfully',error: true);
          Navigator.pushNamed(context,'/reset_password', arguments: {'email': _emailController.text},);
        }
      },
      child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: Utility.getDeviceHeight(context) * 0.3,
                  color: Colors.blue,
                  child: Row(
                    children: [
                      Image.asset(AssetManager.earth.value,
                          width: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.contain,
                          height: 120
                      ),
                      Flexible(
                        child:Container(
                          child:  titleText,
                          margin:EdgeInsets.symmetric(horizontal: 19)
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: Utility.getDeviceHeight(context) * 0.62,
                  padding: EdgeInsets.fromLTRB(20, 55, 20, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 5.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [

                      headingText,
                      SizedBox(
                        height: 30,
                      ),

                      TextFormField(
                        decoration: InputDecoration(
                            labelText: Strings.emailAddress,
                            errorText: validationService.email.error,
                            labelStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.BORDER_COLOR,fontSize: 13),
                            errorStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.ERROR_TEXT_COLOR,fontSize: 12),
                            fillColor:AppColors.INPUT_BG_COLOR,
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(Icons.email),
                            ),
                            filled: true,
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppColors.SUCCESS_COLOR,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color:AppColors.BORDER_COLOR,
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppColors.ERROR_COLOR,
                                width: 1.0,
                              ),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: AppColors.ERROR_COLOR,
                                width: 1.0,
                              ),
                            )
                        ),

                        onChanged: (text) {
                          validationService.changeEmail(text);
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,

                      ),
                      SizedBox(
                        height: 15,
                      ),



                      const SizedBox(
                        height: 26,
                      ),


                      // SizedBox(
                      //   width: Utility.getDeviceWidth(context) * 0.57,
                      //   height: 50,
                      //   child: DecoratedBox(
                      //     decoration: BoxDecoration(
                      //         gradient: (!validationService.isValid) ? LinearGradient(colors: [Colors.blue[100], Colors.blue[100]]) : LinearGradient(colors: [AppColors.BLUE_GRAD_ONE, AppColors.BLUE_GRAD_TWO]),
                      //         borderRadius:  BorderRadius.circular(10.0)
                      //     ),
                      //     child: ElevatedButton(
                      //       child: Text(Strings.resetPassword.toUpperCase(),style: TextStyle(fontSize: 16,fontFamily: "SGIcons",color: Colors.white),),
                      //       style: ElevatedButton.styleFrom(
                      //           primary: Colors.transparent,
                      //           shadowColor: Colors.transparent,
                      //     onPrimary:Colors.transparent,
                      //     shape:  RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(10.0),
                      //         side: BorderSide(color: Colors.transparent)
                      //     )
                      //       ),
                      //       onPressed: (!validationService.isValid) ? null :  _onResetButtonPressed,
                      //
                      //     ),
                      //   ),
                      // ),
                      InkWell(
                        onTap:  (!validationService.isValid) ? null :  _onResetButtonPressed,
                        child: bottomButton,
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      bottomText,
                      SizedBox(height: 50,),
                      bottomContainer


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
