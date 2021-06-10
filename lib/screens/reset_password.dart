import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slider_widget/blocs/forgot_password/bloc.dart';
import 'package:slider_widget/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:slider_widget/blocs/reset_password/bloc.dart';
import 'package:slider_widget/blocs/reset_password/reset_password_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/forgot_password_validation.dart';
import 'package:slider_widget/utils/login_validation.dart';
import 'package:slider_widget/utils/reset_password_validation.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';



class ResetPassword extends StatefulWidget {
  ResetPassword({Key key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>{


  ResetPasswordBloc  _resetPasswordBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState()  {
    super.initState();
    //rest code here
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);

  }

  @override
  void dispose() {
    //rest code here
    _resetPasswordBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.resetPassword,style: TextStyle(fontFamily: 'SGIcons')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body:   BlocListener<ResetPasswordBloc, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordError) {
              Utility.showMessage('Server Error',error: true);
              //Navigator.pushNamed(context,'/home');
            }
            if (state is ResetPasswordSuccess){
             Navigator.of(context).pop();
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
      _wrapNotifier(),
      BlocBuilder<ResetPasswordBloc,ResetPasswordState>(
        builder: (context, state) {
          if (state is ResetPasswordLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );

  Widget _wrapNotifier() => ChangeNotifierProvider<ResetPasswordValidation>(
    create: (_) => ResetPasswordValidation(),
    child: new _ResetPasswordForm(),
  );


}


class _ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<_ResetPasswordForm> {

  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  ResetPasswordBloc _resetPasswordBloc;

  @override
  void initState()  {
    super.initState();
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);

  }

  @override
  void dispose() {
    _resetPasswordBloc.close();
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
        new TextSpan(text: Strings.welcomeBackTo,style: TextStyle(fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.sirius, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22,fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.geography,style: TextStyle(fontFamily: 'SGIcons'))
      ],
    ),
  );

  var headingText = new Text(Strings.resetPassword, style: new TextStyle(
      fontSize: 25.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
      fontFamily: 'SGIcons'
  ));

  var bottomText =new Text(Strings.weHaveSentEmailTo,
    style: new TextStyle(
      fontSize: 14.0,
      color: Colors.grey,
      fontWeight: FontWeight.w400,fontFamily: 'SGIcons'
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




  @override
  Widget build(BuildContext context) {

    final _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
    final validationService = Provider.of<ResetPasswordValidation>(context);
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    _onResetButtonPressed() {
      FocusScope.of(context).requestFocus(FocusNode());
      _resetPasswordBloc.add(ResetPasswordSubmit(email: arguments['email'],password: _passwordController.text,confirmPassword: _confirmPasswordController.text));

    }



    return BlocBuilder<ResetPasswordBloc,ResetPasswordState>(
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
                        height: 140
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
                //height: Utility.getDeviceHeight(context) * 0.62,
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
                    SizedBox(height: 15,),
                    Text(
                      "${Strings.email} :",style: TextStyle(color: Colors.grey,fontSize: 12,fontFamily: 'SGIcons'),),
                    if (arguments != null)  Text(arguments['email'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: 'SGIcons'),),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: Strings.password,
                          errorText: validationService.password.error,
                          labelStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.BORDER_COLOR,fontSize: 13),
                          errorStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.ERROR_TEXT_COLOR,fontSize: 12),
                          fillColor:AppColors.INPUT_BG_COLOR,
                          prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(Icons.lock),
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
                              color: AppColors.BORDER_COLOR,
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
                      obscureText: true,
                      controller: _passwordController,

                      onChanged: (text) {
                        // _loginBloc.add(LoginPasswordChanged(password: text));
                        validationService.changePassword(text);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: Strings.confirmPassword,
                          errorText: validationService.confirmPassword.error,
                          labelStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.BORDER_COLOR,fontSize: 13),
                          errorStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.ERROR_TEXT_COLOR,fontSize: 12),
                          fillColor:AppColors.INPUT_BG_COLOR,
                          prefixIcon: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 12.0),
                            child: Icon(Icons.lock),
                          ),
                          filled: true,
                          isDense: true,
                          border: InputBorder.none,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color:AppColors.SUCCESS_COLOR,
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
                              color:AppColors.ERROR_COLOR,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color:AppColors.ERROR_COLOR,
                              width: 1.0,
                            ),
                          )

                      ),
                      obscureText: true,
                      controller: _confirmPasswordController,

                      onChanged: (text) {
                        // _loginBloc.add(LoginPasswordChanged(password: text));
                        validationService.changeConfirmPassword(text);
                      },
                    ),
                    const SizedBox(
                      height: 26,
                    ),
                    bottomContainer,
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: Utility.getDeviceWidth(context) * 0.57,
                      height: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            gradient: (!validationService.isValid) ? LinearGradient(colors: [Colors.blue[100], Colors.blue[100]]) : LinearGradient(colors: [AppColors.BLUE_GRAD_ONE, AppColors.BLUE_GRAD_TWO]),
                            borderRadius:  BorderRadius.circular(10.0)
                        ),
                        child: ElevatedButton(
                          child: Text(Strings.resetPassword.toUpperCase(),style: TextStyle(fontSize: 16,fontFamily: "SGIcons",color: Colors.white),),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              shadowColor: Colors.transparent,
                              onPrimary:Colors.transparent,
                              shape:  RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Colors.transparent)
                              )
                          ),
                          onPressed: (!validationService.isValid) ? null :  _onResetButtonPressed,

                        ),
                      ),
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
    );
  }


}
