import 'package:flutter/material.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import './validation.dart';


class LoginValidation with ChangeNotifier {

  ValidationItem _email = ValidationItem(null,null);
  ValidationItem _password = ValidationItem(null,null);

  //Getters
  ValidationItem get email => _email;
  ValidationItem get password => _password;

  bool get isValid {
    if (_password.value != null && _email.value != null && ValidationMixin.validateEmailAddress(_email.value)){
      return true;
    } else {
      return false;
    }
  }

  //Setters
  void changeEmail(String value){
    if (value.length >= 3){
      _email = ValidationItem(value,null);
    }
    else {
      _email = ValidationItem(null, "Email Must be at least 3 characters");
    }
    if(!ValidationMixin.validateEmailAddress(value)){
      _email = ValidationItem(null, "Email Must be valid");
    }
    notifyListeners();
  }

  void changePassword(String value){
    if (value.length >= 8){
      _password = ValidationItem(value,null);
    } else {
      _password = ValidationItem(null, "Password Must be at least 8 characters");
    }
    notifyListeners();
  }



}