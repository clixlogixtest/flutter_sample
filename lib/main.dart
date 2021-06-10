

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:slider_widget/blocs/api/api_bloc.dart';
import 'package:slider_widget/blocs/forgot_password/bloc.dart';
import 'package:slider_widget/blocs/reset_password/bloc.dart';
import 'package:slider_widget/blocs/signup/bloc.dart';
import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/screens/forgot_password.dart';
import 'package:slider_widget/screens/login.dart';
import 'package:slider_widget/screens/signup.dart';
import 'package:slider_widget/screens/signup_final.dart';
import 'package:slider_widget/screens/signup_two.dart';
import 'package:slider_widget/screens/splash.dart';
import 'package:slider_widget/simple_bloc_observer.dart';




//customs
import 'blocs/blocs.dart';
import 'screens/screens.dart';

final ThemeData defaultTheme = new ThemeData(
  primaryColor: Colors.black,
  accentColor: Colors.orangeAccent,
  brightness: Brightness.light,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Bloc.observer = SimpleBlocObserver();
  SharedPreferences.setMockInitialValues({});

  runApp(MyApp());
}




Map<String,WidgetBuilder> routes = {

  '/':  (context) => new SplashScreen(),


  '/login': (context) => BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(
           userBloc:  BlocProvider.of<UserBloc>(context)
        ),
         child: Login(),
    ),

  '/signup': (context) => BlocProvider<LoginBloc>(
    create: (context) => LoginBloc(
        userBloc:  BlocProvider.of<UserBloc>(context)
    ),
    child: SignUp(),
  ),

  '/signup_two': (context) => BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(
          userBloc:  BlocProvider.of<UserBloc>(context)
      ),
      child: SignUpTwo(),
  ),

  '/signup_final': (context) => BlocProvider<SignUpBloc>(
    create: (context) => SignUpBloc(
        userBloc:  BlocProvider.of<UserBloc>(context)
    ),
    child: SignUpFinal(),
  ),


  '/forgot_password': (context) => BlocProvider<ForgotPasswordBloc>(
          create: (context) => ForgotPasswordBloc(),
          child: ForgotPassword(),
   ),

  '/reset_password': (context) => BlocProvider<ResetPasswordBloc>(
    create: (context) => ResetPasswordBloc(),
    child: ResetPassword(),
  ),


  '/home':  (context) =>MultiBlocProvider(
    providers: [
      BlocProvider<ApiBloc>(  create: (context) => ApiBloc()),

    ],
    child:new Home(),
  ),



};





class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{


  @override
  void initState(){

    super.initState();

  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create:  (context) => UserBloc(),
      child: MaterialApp(
      title: '3 Point Application',
      theme: defaultTheme,
      //home: Splash(),
      initialRoute: '/',
      routes: routes,
      debugShowCheckedModeBanner: false,

    ),);
  }
}






