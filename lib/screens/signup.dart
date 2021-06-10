import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:slider_widget/blocs/blocs.dart';
import 'package:slider_widget/blocs/forgot_password/bloc.dart';
import 'package:slider_widget/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/constants.dart';
import 'package:slider_widget/utils/forgot_password_validation.dart';
import 'package:slider_widget/utils/login_validation.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:slider_widget/widgets/social_button.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sign_button/sign_button.dart';



class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{


  LoginBloc _loginBloc;
  final _scaffoldKey = GlobalKey<ScaffoldState>();



  @override
  void initState()  {
    super.initState();
    //rest code here
    _loginBloc = BlocProvider.of<LoginBloc>(context);

  }

  @override
  void dispose() {
    //rest code here
    _loginBloc.close();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.signup,style: TextStyle(fontFamily: 'SGIcons'),),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.white,
        body:   BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              Utility.showMessage(state.error,error: true);
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
      BlocBuilder<LoginBloc,LoginState>(
        builder: (context, state) {
          if (state is LoginLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );

  Widget _wrapNotifier() => ChangeNotifierProvider<ForgotPasswordValidation>(
    create: (_) => ForgotPasswordValidation(),
    child: new _SignUpForm(),
  );


}


class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {

  final _emailController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState()  {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);

  }


  void signInWithGoogle() async {
    _loginBloc.add(LoginWithGoogle());
  }

  void signInWithFacebook() async {
    _loginBloc.add(LoginWithFacebook());
  }

  void signWithTwitter() async{
    _loginBloc.add(LoginWithTwitter());
  }

  @override
  void dispose() {
    _loginBloc.close();
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
        new TextSpan(text: Strings.createYour,style: TextStyle(fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.account, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22,fontFamily: 'SGIcons')),
      ],
    ),
  );








  @override
  Widget build(BuildContext context) {

    final validationService = Provider.of<ForgotPasswordValidation>(context);

    _onSignUpButtonPressed() {
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.pushReplacementNamed(context,'/signup_two', arguments: {'email': _emailController.text},);

    }



    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          // _showError(state.error);
        }
        if (state is LoginSuccess){
          // Utility.showMessage('Done Successfully',error: true);
          Navigator.pushNamed(context,'/home');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                 // height: Utility.getDeviceHeight(context) * 0.62,
                  transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                  padding: EdgeInsets.fromLTRB(20, 55, 20, 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
                    color: Colors.white,

                  ),
                  child: Column(
                    children: [

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

                      SizedBox(
                        width: Utility.getDeviceWidth(context) * 0.6,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              gradient: (!validationService.isValid) ? LinearGradient(colors: [Colors.green[100], Colors.green[100]]) : LinearGradient(colors: [AppColors.GREEN_GRAD_ONE, AppColors.GREEN_GRAD_TWO]),
                              borderRadius:  BorderRadius.circular(10.0)
                          ),
                          child: ElevatedButton(
                            child: Text(Strings.signup.toUpperCase(),style: TextStyle(fontSize: 16,fontFamily: "SGIcons",color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary:Colors.transparent,
                                shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.transparent)
                                )


                            ),
                            onPressed: (!validationService.isValid) ? null :  _onSignUpButtonPressed,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      InkWell(
                        onTap: () => Navigator.of(context).pop(),
                        child:  RichText(
                          text: TextSpan(
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${Strings.alreadyHaveAccount} ? ",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: 'SGIcons', color: AppColors.BLACK_TEXT_COLOR,),
                              ),
                              TextSpan(
                                text: Strings.login,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.BLACK_TEXT_COLOR,
                                    fontSize: 14,decoration: TextDecoration.underline,fontFamily: 'SGIcons'
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 15,),
                      Text(Strings.or,style: TextStyle( fontSize: 14,fontFamily: 'SGIcons',color: AppColors.LIGHT_GREY_TEXT_COLOR),),
                      SizedBox(height: 25,),
                      SocialButton(text:  Strings.loginWithGoogle,onPressed:()=>  signInWithGoogle() ,image: AssetManager.google.value,),
                      SizedBox(height: 15,),
                      SocialButton(text:  Strings.loginWithFacebook,onPressed:()=>  signInWithFacebook() ,image: AssetManager.facebook.value,),
                      SizedBox(height: 15,),
                      SocialButton(text:  Strings.loginWithTwitter,onPressed:()=>  signWithTwitter() ,image: AssetManager.twitter.value,),
                      SizedBox(height: 15,),



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
