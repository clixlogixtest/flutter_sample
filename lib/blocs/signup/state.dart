import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class SignUpState extends Equatable {
  const SignUpState();
  @override
  List<Object> get props => [];
}


class SignUpInitial extends SignUpState {
  const SignUpInitial();
  @override
  String toString()  =>  "SignUp Initial";
}

class SignUpLoading extends SignUpState {
  @override
  String toString()  =>  "SignUp Loading";
}

class SignUpSuccess extends SignUpState {
  //when api call is success then pass the success json response to calling method
  final dynamic jsonResponse;
  const SignUpSuccess({@required this.jsonResponse}) : assert(jsonResponse != null);
  @override
  List<Object> get props => [jsonResponse];
}


class SignUpFinalSuccess extends SignUpState {
  //when final sign up is done from into screen
  @override
  String toString()  =>  "SignUpFinalSuccess";
}


class SignUpError extends SignUpState {
  final String error;
  SignUpError({@required this.error});

  @override
  String toString()  =>  "SignUp Error";

  @override
  List<Object> get props => [error];
}