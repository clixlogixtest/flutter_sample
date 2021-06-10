import 'package:flutter/material.dart';
import './validation.dart';


class ResetPasswordValidation with ChangeNotifier {

  ValidationItem _password = ValidationItem(null,null);
  ValidationItem _confirmPassword = ValidationItem(null,null);

  //Getters
  ValidationItem get confirmPassword => _confirmPassword;
  ValidationItem get password => _password;

  bool get isValid {
    if (_password.value != null && _confirmPassword.value != null  && _password.value == _confirmPassword.value){
      return true;
    } else {
      return false;
    }
  }

  //Setters

  void changePassword(String value){
    if (value.length >= 8){
      _password = ValidationItem(value,null);
    } else {
      _password = ValidationItem(null, "Password Must be at least 8 characters");
    }
    notifyListeners();
  }

  void changeConfirmPassword(String value){
    if (value.length >= 8){
      _confirmPassword = ValidationItem(value,null);
    } else {
      _confirmPassword = ValidationItem(null, "Password Must be at least 8 characters");
    }
    if(value != password.value){
      _confirmPassword = ValidationItem(null, "Password and confirm Password must be same");
    }
    notifyListeners();
  }




}