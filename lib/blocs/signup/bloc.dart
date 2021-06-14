import 'package:bloc/bloc.dart';
import 'package:slider_widget/blocs/signup/event.dart';
import 'package:slider_widget/blocs/signup/signup_bloc.dart';
import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:slider_widget/controllers/api_repository.dart';
import 'package:slider_widget/models/models.dart';
import 'package:slider_widget/utils/constants.dart';
import 'package:slider_widget/utils/storage_helper.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final repository = ApiRepository();

  final userBloc ;

  SignUpBloc({UserBloc userBloc})
      : assert(userBloc != null),
        userBloc = userBloc ,
        super(SignUpInitial());


  static final FacebookLogin facebookSignIn = new FacebookLogin();
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
    ],
  );


  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is SignUpSubmit) {
      yield* _mapSignUpWithState(event);
    }
    if (event is SignUpSubmitFinal) {
      yield* _mapSignUpFinalWithState(event);
    }
    if (event is RegisterWithGoogle) {
      yield* _mapRegisterWithGoogle(event);
    }
    if (event is RegisterWithFacebook) {
      yield* _mapRegisterWithFacebook(event);
    }
    if (event is RegisterWithTwitter) {
      yield* _mapRegisterWithTwitter(event);
    }
  }

  Stream<SignUpState> _mapSignUpWithState(SignUpSubmit event) async* {

    yield SignUpLoading();

    try {
      if (true) {
        String email = event.email;
        String password = event.password;
        String confirmPassword =  event.confirmPassword;
        String name =  event.name;

        final  result = await repository.postSignUpData(email,password,name,confirmPassword);
        String id = result['id'].toString();
        //String token = result['token'];

        await MySharedPreferences.instance.setStringValue('id', id);
        String i = await MySharedPreferences.instance.getStringValue('id');
        print('id is ' + i.toString());

        yield SignUpSuccess(jsonResponse: result);
        yield SignUpInitial();
      } else {
        yield SignUpError(error: 'Something very weird just happened');
      }
    } on FetchDataException catch (e) {
      yield SignUpError(error:e.toString());
    } catch (err) {
      yield SignUpError(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<SignUpState> _mapSignUpFinalWithState(SignUpSubmitFinal event) async* {
    yield SignUpLoading();

    try {
      if (true) {
        String id = event.id;
        String name = event.name;
        String email = event.email;
        String token = event.token;

        userBloc.add(UserLoggedIn(user: User(id:id,name: name,email: email,token: token)));

        yield SignUpFinalSuccess();
        yield SignUpInitial();
      } else {
        yield SignUpError(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield SignUpError(error:e.toString());
    }catch (err) {
      yield SignUpError(error: err.message ?? 'An unknown error occured');
    }
  }

  Stream<SignUpState> _mapRegisterWithGoogle(RegisterWithGoogle event) async* {
    yield SignUpLoading();



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

        yield SignUpSuccess();
        yield SignUpInitial();
      } else {
        yield SignUpError(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield SignUpError(error:e.toString());
    }catch (err) {
      yield SignUpError(error:  'Sign In Failed');
    }
  }

  Stream<SignUpState> _mapRegisterWithFacebook(RegisterWithFacebook event) async* {
    yield SignUpLoading();
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

            yield SignUpSuccess();
            yield SignUpInitial();

            break;
          case FacebookLoginStatus.cancelledByUser:
            print('Login cancelled by the user.');
            yield SignUpError(error:'Login cancelled by the user.');
            break;
          case FacebookLoginStatus.error:

            yield SignUpError(error:'Something went wrong with the login process.\n'
                'Here\'s the error Facebook gave us: ${fBresult.errorMessage}');
            break;
        }

      } else {
        yield SignUpError(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield SignUpError(error:e.toString());
    }catch (err) {
      yield SignUpError(error:  'Sign In Failed');
    }
  }

  Stream<SignUpState> _mapRegisterWithTwitter(RegisterWithTwitter event) async* {
    yield SignUpLoading();



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

            yield SignUpSuccess(jsonResponse: result);
            yield SignUpInitial();

            //Utility.showMessage('Welcome ${authResult.user.name} ',error: false);
            break;
          case TwitterLoginStatus.cancelledByUser:
          // cancel
            print('====== Login cancel ======');
            yield SignUpError(error:'Login canceled by User');
            break;
          case TwitterLoginStatus.error:
            print('====== Login error ======');
            yield SignUpError(error: 'Login error');
            break;
        }



      } else {
        yield SignUpError(error: 'Something very weird just happened');
      }
    }on FetchDataException catch (e) {
      yield SignUpError(error:e.toString());
    }catch (err) {
      yield SignUpError(error:  'Sign In Failed');
    }
  }

}
