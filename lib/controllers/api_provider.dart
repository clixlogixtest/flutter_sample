import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:slider_widget/utils/constants.dart';

/*
For making communication between our Remote server and Application we use various APIs which needs some type of HTTP methods to get executed.
So we are first going to create a base API helper class, which will be going to help us communicate with our server.
*/



class ApiProvider {

  Future<dynamic> getRequest(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.https('authority', "unencodedPath"));
      responseJson = _response(response);
      print(responseJson);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> getRequestToken(String url,String token) async {
    Map<String, String> headers = {"Content-type": "application/json",  "Authorization": 'Bearer $token' };
    var responseJson;
    try {
      final response = await http.get( Uri.https('authority', "unencodedPath"),headers: headers);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postRequest(Map<String,dynamic> parameters,String url) async {
    // set up POST request arguments
    Map<String, String> headers = {"Content-type": "application/json"};
    Map<String, dynamic> json = parameters;
    print(url);
    var responseJson;
    try {
      final response = await http.post(Uri.parse(url), headers: headers, body:  jsonEncode(json));
      var temp  = response.body;
      print('Server response ---->>>>> ');
      print(temp);
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

  }


  Future<dynamic> postRequestToken(Map<String,dynamic> parameters,String url,String token) async {
    // set up POST request arguments
    Map<String, String> headers = {"Content-type": "application/json",  "Authorization": 'Bearer $token' };
    Map<String, dynamic> json = parameters;

    var responseJson;
    try {
      final response = await http.post(Uri.https('authority', "unencodedPath"), headers: headers, body:  jsonEncode(json));
      var temp  = response.body;
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;

  }

  dynamic _response(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 201:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        var responseJson = json.decode(response.body.toString());
        throw UnauthorisedException(responseJson['message']); //called when authentication failed
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('Error Occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}