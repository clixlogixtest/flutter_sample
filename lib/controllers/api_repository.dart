import 'package:slider_widget/controllers/api_provider.dart';
import 'package:slider_widget/utils/constants.dart';

/*
We are going to use a Repository class which going to act as the inter-mediator and a layer of abstraction between the APIs and the BLOC.
 The task of the repository is to deliver movies data to the BLOC after fetching it from the API.
*/


class ApiRepository {

  ApiProvider _provider = ApiProvider();

  //to make post request , a generic method
  Future<dynamic> makePostRequest(String url, Map<String,dynamic> parameters) async {
    final response = await _provider.postRequest(parameters,url);
    return response ;
  }

  //to make post request , a generic method .. using token
  Future<dynamic> makePostRequestToken(String url, Map<String,dynamic> parameters,String token) async {
    final response = await _provider.postRequestToken(parameters,url,token);
    return response ;
  }


  //to make get request using token, a generic method
  Future<dynamic> makeGetRequestToken(String url,String token) async {
    final response = await _provider.getRequestToken(url,token);
    return response ;
  }


  //to make get request , a generic method
  Future<dynamic> makeGetRequest(String url) async {
    final response = await _provider.getRequest(url);
    return response ;
  }


  Future<dynamic> getHomeData(String url,String token) async {
    final response = await _provider.getRequestToken(url,token);
    return response ;
  }

  Future<dynamic> postLoginData(String email , String password,String deviceName) async {
      Map<String, dynamic> parameters =  {
                "email": email,
               "password": password,
                "device_name": deviceName,
           };


      final response = await _provider.postRequest(parameters,AppConstants.LOGIN);
      print(response);
      return response ;
  }

  Future<dynamic> postSignUpData(String email , String password,String name,String confirmPassword) async {
    Map<String, dynamic> parameters =  {
      "email": email,
      "password": password,
      "password_confirmation": confirmPassword,
      "name":name
    };


    final response = await _provider.postRequest(parameters,AppConstants.REGISTER);
    print(response);
    return response ;
  }


  Future<dynamic> postSocialRegister(String socialtype , String socialdata,String socialtoken,String socialid) async {

    Map<String, dynamic> parameters =  {
      "socialtype": socialtype,
      //"socialdata": socialdata,
      "socialtoken": socialtoken,
      "socialid": socialid,
    };
      print(AppConstants.SOCIAL_REGISTER);

    final response = await _provider.postRequest(parameters,AppConstants.SOCIAL_REGISTER);
    return response ;
  }


  Future<dynamic> postForgotPassword(String email ) async {
    Map<String, dynamic> parameters =  {
      "email": email,
    };

    final response = await _provider.postRequest(parameters,AppConstants.FORGOT_PASSWORD);
    print(response);
    return response ;
  }

  Future<dynamic> postResetPassword(String email ,String password, String confirmPassword) async {
    Map<String, dynamic> parameters =  {
      "email": email,
      "password":password,
      "password_confirmation":confirmPassword
    };

    final response = await _provider.postRequest(parameters,AppConstants.RESET_PASSWORD);
    print(response);
    return response ;
  }


}