import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/constants.dart';
import 'package:slider_widget/utils/login_validation.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import 'package:slider_widget/widgets/social_button.dart';

import '../blocs/blocs.dart';
import '../blocs/blocs.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sign_button/sign_button.dart';


class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{


  bool isChecked = false;
  String deviceToken = "";
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
    // print(_loginBloc.state.toString());
    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(Strings.login,style: TextStyle(fontFamily: 'SGIcons'),),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
        body:   BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
               Utility.showMessage(state.error,error: true);
             // Utility.showMessage('Server error occured !',error: true);
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
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );

  Widget _wrapNotifier() => ChangeNotifierProvider<LoginValidation>(
    create: (_) => LoginValidation(),
    child: new _SignInForm(),
  );


}


class _SignInForm extends StatefulWidget {
  @override
  __SignInFormState createState() => __SignInFormState();
}

class __SignInFormState extends State<_SignInForm> {

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  LoginBloc _loginBloc;

  @override
  void initState()  {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);

  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }



  Future<dynamic> signInWithGoogle() async {
    _loginBloc.add(LoginWithGoogle());
  }
  Future<Null> signInWithFacebook() async {
    _loginBloc.add(LoginWithFacebook());
  }
  void signWithTwitter() async{
    _loginBloc.add(LoginWithTwitter());
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
        new TextSpan(text: '${Strings.welcomeBackTo}',style: TextStyle(fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.sirius, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22,fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.geography,style: TextStyle(fontFamily: 'SGIcons'))
      ],
    ),
  );

  var signUpText = new RichText(
    text: TextSpan(
      style: new TextStyle(
        fontSize: 18.0,
        color: Colors.black,
      ),
      children: <TextSpan>[
        TextSpan(
          text: Strings.dontHaveAccount,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,fontFamily: 'SGIcons',color: AppColors.BLACK_TEXT_COLOR),
        ),
        TextSpan(
          text: 'Register',
          style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.black,
              fontSize: 14),
        ),
      ],
    ),
  );



  @override
  Widget build(BuildContext context) {

    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    final validationService = Provider.of<LoginValidation>(context);

    _onLoginButtonPressed() {
      _loginBloc.add(LoginInWithEmailButtonPressed(email: _emailController.text, password: _passwordController.text));

    }

    _emptyFields(){
      _emailController.clear();
      _passwordController.clear();
    }

    _navigateToForgotPassword(){

       Navigator.pushNamed(context,'/forgot_password');
       _emptyFields();
    }
    _navigateToSignUp(){
      Navigator.pushNamed(context,'/signup');
      _emptyFields();
    }



    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
         // _showError(state.error);
        }
        if (state is LoginSuccess){

          Navigator.pushNamed(context,'/home');
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {

          return SingleChildScrollView(
            physics: new ClampingScrollPhysics(),
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
                        child: Container(
                         child: titleText,
                          margin: EdgeInsets.symmetric(horizontal: 20),
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
                      SizedBox(
                        height: 20,
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
                          // _loginBloc.add(LoginEmailChanged(email: text));
                          validationService.changeEmail(text);
                        },
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,

                      ),
                      SizedBox(
                        height: 15,
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
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: AppColors.ERROR_COLOR,
                              width: 1.0,
                            ),
                          ) ,
                          focusedErrorBorder: OutlineInputBorder(
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
                      const SizedBox(height: 16, ),

                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => _navigateToForgotPassword(),
                          child: Text(
                              '${Strings.forgotPassword}?',style: TextStyle(decoration:
                          TextDecoration.underline,fontSize: 14,fontWeight: FontWeight.w800,fontFamily: 'SGIcons',color: AppColors.DARK_TEXT_COLOR),),
                        )
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      SizedBox(
                        width: Utility.getDeviceWidth(context) * 0.6,
                        height: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(

                              gradient: (!validationService.isValid) ? LinearGradient(colors: [Colors.blue[100], Colors.blue[100]]) : LinearGradient(colors: [AppColors.BLUE_GRAD_ONE, AppColors.BLUE_GRAD_TWO]),
                              borderRadius:  BorderRadius.circular(10.0)
                          ),
                          child: ElevatedButton(
                            child: Text(Strings.logIn.toUpperCase(),style: TextStyle(fontSize: 16,fontFamily: "SGIcons",color: Colors.white),),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.transparent,
                                shadowColor: Colors.transparent,
                                onPrimary:Colors.transparent,
                                shape:  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: Colors.transparent)
                                )
                            ),
                            onPressed: (!validationService.isValid) ? null :  _onLoginButtonPressed,

                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                     InkWell(
                       onTap: () => _navigateToSignUp(),
                       child:  RichText(
                         text: TextSpan(
                           style: new TextStyle(
                             fontSize: 18.0,
                             color: Colors.black,
                           ),
                           children: <TextSpan>[
                             TextSpan(
                               text: '${Strings.dontHaveAccount} ? ' ,
                               style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: 'SGIcons',color: AppColors.BLACK_TEXT_COLOR),
                             ),
                             TextSpan(
                               text:Strings.signUp,
                               style: TextStyle(
                                   fontWeight: FontWeight.w800,
                                   color: Colors.black,
                                   fontSize: 14,decoration: TextDecoration.underline,fontFamily: 'SGIcons'
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                      SizedBox(height: 10,),
                      Text(Strings.or,style: TextStyle( fontSize: 14,fontFamily: 'SGIcons',color: AppColors.LIGHT_GREY_TEXT_COLOR),),
                      SizedBox(height: 15,),
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

  void _showError(String error) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(error),
      backgroundColor: Theme.of(context).errorColor,
    ));
  }
}
