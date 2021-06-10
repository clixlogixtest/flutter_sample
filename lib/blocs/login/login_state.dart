import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


enum FieldError { Empty, Invalid ,Default,Valid}


class LoginScreenState  extends Equatable {
  final bool isBusy;
  final FieldError emailError;
  final FieldError passwordError;
  final bool loginSuccess;
  final String loginError;

  LoginScreenState({
    this.isBusy : false,
    this.emailError ,
    this.passwordError,
    this.loginSuccess,
    this.loginError
  });

  @override
  List<Object> get props => [isBusy,emailError,loginError,passwordError,loginSuccess];
}




abstract class LoginState extends Equatable{
  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error});

  @override
  List<Object> get props => [error];
}