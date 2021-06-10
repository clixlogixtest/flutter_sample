import 'package:flutter/material.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import './validation.dart';


class ForgotPasswordValidation with ChangeNotifier {

  ValidationItem _email = ValidationItem(null,null);

  //Getters
  ValidationItem get email => _email;

  bool get isValid {
    if (_email.value != null){
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


}