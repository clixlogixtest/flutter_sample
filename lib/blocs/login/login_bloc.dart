import 'package:bloc/bloc.dart';
import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:slider_widget/controllers/api_repository.dart';
import 'package:slider_widget/models/models.dart';
import 'package:slider_widget/utils/constants.dart';
import 'package:slider_widget/utils/storage_helper.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import '../blocs.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'dart:io' show Platform;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;



class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final repository = ApiRepository();
  final userBloc ;

  LoginBloc({UserBloc userBloc})
      : assert(userBloc != null),
        userBloc = userBloc ,
        super(LoginInitial());



  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginInWithEmailButtonPressed) {
      yield* _mapLoginWithEmailToState(event);
    }
    if (event is LoginWithSocial) {
      yield* _mapRegisterWithSocial(event);
    }
    if (event is LoginWithGoogle) {
      yield* _mapRegisterWithGoogle(event);
    }
    if (event is LoginWithFacebook) {
      yield* _mapRegisterWithFacebook(event);
    }
    if (event is LoginWithTwitter) {
      yield* _mapRegisterWithTwitter(event);
    }
  }

  Stream<LoginState> _mapLoginWithEmailToState(LoginInWithEmailButtonPressed event) async* {

    yield LoginLoading();

    try {
      if (true) {
        //await Future.delayed(const Duration(seconds: 2), (){});
        String email = event.email;
        String password = event.password;
        String device_name =   Platform.isIOS ? 'iphone' : 'android';

        final  result = await repository.postLoginData(email,password,device_name);
        String name = result['user']['name'];
        String id = result['user']['id'].toString();
        String token = result['token'];

        await MySharedPreferences.instance.setStringValue('id', id);
        String i = await MySharedPreferences.instance.getStringValue('id');
        print('id is ' + i.toString());
        userBloc.add(UserLoggedIn(user: User(id:id,name: name,email: email,token: token)));

        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    } on FetchDataException catch (e) {
      yield LoginFailure(error:'A server error occured');
    } catch (err) {
      yield LoginFailure(error: err.message ?? 'A server error occured');
    }
  }

  Stream<LoginState> _mapRegisterWithSocial(LoginWithSocial event) async* {
    yield LoginLoading();



    try {
      if (true) {
        String socialtype = event.socialtype;
        String socialdata = event.socialdata;
        String socialtoken = event.socialtoken;
        String socialid = event.socialid;
        String device_name =   Platform.isIOS ? 'iphone' : 'android';

        final  result = await repository.postSocialRegister(socialtype,socialdata,socialtoken,socialid);

        String name = result['user']['name'];
        String email = result['user']['email'];
        String id = result['user']['id'].toString();
        String token = result['token'];

        MySharedPreferences.instance.setStringValue('id', id);
        userBloc.add(UserLoggedIn(user: User(id:id,name: name,email: email,token: token)));

        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield LoginFailure(error:e.toString());
    }catch (err) {
      yield LoginFailure(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<LoginState> _mapRegisterWithFacebook(LoginWithFacebook event) async* {
    yield LoginLoading();
    try {
      if (true) {

        final FacebookLoginResult fBresult =  await facebookSignIn.logIn(['email']);

          switch (fBresult.status) {
            case FacebookLoginStatus.loggedIn:
              final FacebookAccessToken accessToken = fBresult.accessToken;
              print('''
                   Logged in!
                   
                   Token: ${accessToken.token}
                   User id: ${accessToken.userId}
                   Expires: ${accessToken.expires}
                   Permissions: ${accessToken.permissions}
                   Declined permissions: ${accessToken.declinedPermissions}
                   '''
              );

            var url = Uri.parse("https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}");
            final response = await http.get(url);
            Map<String, dynamic> profile = jsonDecode(response.body);



            String socialType ='facebook';
            String socialData = '';
            String socialToken = accessToken.token;
            String socialId = accessToken.userId;

            final  result = await repository.postSocialRegister(socialType,socialData,socialToken,socialId);

            String name = result['user']['name'];
            String email = result['user']['email'];
            String id = result['user']['id'].toString();
            String token = result['token'];

            MySharedPreferences.instance.setStringValue('id', id);
            userBloc.add(UserLoggedIn(user: User(id:id,name: '${profile['first_name']}' + ' ' '${profile['last_name']}',email: email,token: token)));

            yield LoginSuccess();
            yield LoginInitial();

            break;
          case FacebookLoginStatus.cancelledByUser:
            print('Login cancelled by the user.');
            yield  LoginFailure(error:'Login cancelled by the user.');

            break;
          case FacebookLoginStatus.error:

            yield LoginFailure(error:'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${fBresult.errorMessage}');
            break;
        }

      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield LoginFailure(error:e.toString());
    }catch (err) {
      yield LoginFailure(error:  'Sign In Failed');
    }
  }

  Stream<LoginState> _mapRegisterWithGoogle(LoginWithGoogle event) async* {
    yield LoginLoading();



    try {
      if (true) {

        GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();

        print("User Name: ${googleSignInAccount.displayName}");
        print("User Email ${googleSignInAccount.id}");



        String socialType ='google';
        String socialData = '';
        String socialToken = googleSignInAccount.id;
        String socialId = googleSignInAccount.id;

        final  result = await repository.postSocialRegister(socialType,socialData,socialToken,socialId);

        String name = result['user']['name'];
        String email = result['user']['email'];
        String id = result['user']['id'].toString();
        String token = result['token'];

        MySharedPreferences.instance.setStringValue('id', id);
        userBloc.add(UserLoggedIn(user: User(id:id,name: googleSignInAccount.displayName,email: email,token: token)));

        yield LoginSuccess();
        yield LoginInitial();
      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield LoginFailure(error:e.toString());
    }catch (err) {
      yield LoginFailure(error:  'Sign In Failed');
    }
  }

  Stream<LoginState> _mapRegisterWithTwitter(LoginWithTwitter event) async* {
    yield LoginLoading();



    try {
      if (true) {

        final twitterLogin = TwitterLogin(
          // Consumer API keys
          apiKey: Keys.TWITTER_API_KEY,
          apiSecretKey: Keys.TWITTER_API_SECRET_KEY,
          redirectURI: 'twittersdk://',
        );
        final authResult = await twitterLogin.login();
        switch (authResult.status) {
          case TwitterLoginStatus.loggedIn:
          // success
            print('====== Login success ======' + authResult.user.id.toString() + '----');
            String socialType ='twitter';
            String socialData = '';
            String socialToken =authResult.user.id.toString();
            String socialId = authResult.user.id.toString();

            final  result = await repository.postSocialRegister(socialType,socialData,socialToken,socialId);

            String name = result['user']['name'];
            String email = result['user']['email'];
            String id = result['user']['id'].toString();
            String token = result['token'];

            MySharedPreferences.instance.setStringValue('id', id);
            userBloc.add(UserLoggedIn(user: User(id:id,name: authResult.user.name,email: email,token: token)));

            yield LoginSuccess();
            yield LoginInitial();

            //Utility.showMessage('Welcome ${authResult.user.name} ',error: false);
            break;
          case TwitterLoginStatus.cancelledByUser:
          // cancel
            print('====== Login cancel ======');
            yield LoginFailure(error:'Login canceled by User');
            break;
          case TwitterLoginStatus.error:
            print('====== Login error ======');
            yield LoginFailure(error: 'Login error');
            break;
        }



      } else {
        yield LoginFailure(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield LoginFailure(error:e.toString());
    }catch (err) {
      yield LoginFailure(error:  'Sign In Failed');
    }
  }

}
