import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slider_widget/blocs/signup/bloc.dart';
import 'package:slider_widget/blocs/signup/signup_bloc.dart';
import 'package:slider_widget/utils/app_colors.dart';
import 'package:slider_widget/utils/signup_validation.dart';
import 'package:slider_widget/utils/strings.dart';
import 'package:slider_widget/widgets/progress_bar.dart';
import 'package:provider/provider.dart';
import '../utils/assets.dart';
import '../utils/utility.dart';




class SignUpTwo extends StatefulWidget {
  SignUpTwo({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpTwo>{


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
          title: Text(Strings.signup,style: TextStyle(fontFamily: 'SGIcons')),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        backgroundColor: Colors.blue,
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
      _wrapNotifier(),
      BlocBuilder<SignUpBloc,SignUpState>(
        builder: (context, state) {
          if (state is SignUpLoading)  return  ProgressBar();
          return Container();
        },
      )
    ],
  );

  Widget _wrapNotifier() => ChangeNotifierProvider<SignUpValidation>(
    create: (_) => SignUpValidation(),
    child: new _SignUpForm(),
  );


}


class _SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {

  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
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
        new TextSpan(text:Strings.createYour,style: TextStyle(fontFamily: 'SGIcons')),
        new TextSpan(text: Strings.account, style: new TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 22,fontFamily: 'SGIcons')),
      ],
    ),
  );








  @override
  Widget build(BuildContext context) {

    final validationService = Provider.of<SignUpValidation>(context);
    final arguments = ModalRoute.of(context).settings.arguments as Map;

    _onSignUpButtonPressed() {
      FocusScope.of(context).requestFocus(FocusNode());
     ///   Navigator.pushNamed(context,'/signup_two', arguments: {'email': _emailController.text},);

      _signUpBloc.add(SignUpSubmit(email: arguments['email'], password: _passwordController.text,
          confirmPassword: _confirmPasswordController.text, name: _nameController.text));

    }



    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpError) {
          // _showError(state.error);
        }
        if (state is SignUpSuccess){
          // Utility.showMessage('Done Successfully',error: true);
          //state.jsonResponse['id'];
          Navigator.pushReplacementNamed(context,'/signup_final', arguments: {
            'email':  arguments['email'],
            'name':_nameController.text,
            'id':state.jsonResponse['id'],
            'token':'Dummytoken1234567890'
          });
        }
      },
      child: BlocBuilder<SignUpBloc, SignUpState>(
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
                        child: titleText,
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

                      SizedBox(
                        height: 30,
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
                                color:AppColors.ERROR_COLOR,
                                width: 1.0,
                              ),
                            )
                        ),

                        onChanged: (text) {
                          validationService.changePassword(text);
                        },
                        controller: _passwordController,
                        obscureText: true,
                        autocorrect: false,

                      ),
                      SizedBox( height: 15 ),
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
                          validationService.changeConfirmPassword(text);
                        },
                        controller: _confirmPasswordController,
                        obscureText: true,
                        autocorrect: false,

                      ),
                      SizedBox( height: 15 ),
                      TextFormField(
                        decoration: InputDecoration(
                            labelText: Strings.name,
                            errorText: validationService.name.error,
                            labelStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.BORDER_COLOR,fontSize: 13),
                            errorStyle: TextStyle(fontFamily: 'SGIcons',color: AppColors.ERROR_TEXT_COLOR,fontSize: 12),
                            fillColor:AppColors.INPUT_BG_COLOR,
                            prefixIcon: Padding(
                              padding: const EdgeInsetsDirectional.only(start: 12.0),
                              child: Icon(Icons.supervised_user_circle),
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
                          validationService.changeName(text);
                        },
                        controller: _nameController,
                        autocorrect: false,

                      ),
                      SizedBox( height: 15 ),
                      SizedBox( height: 15 ),



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
                        onTap: () => {
                          Navigator.of(context).pop(),
                          Navigator.of(context).pop()
                        },
                        child:  RichText(
                          text: TextSpan(
                            style: new TextStyle(
                              fontSize: 18.0,
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: "${Strings.alreadyHaveAccount} ? ",
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14,fontFamily: 'SGIcons',color: AppColors.BLACK_TEXT_COLOR),
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
