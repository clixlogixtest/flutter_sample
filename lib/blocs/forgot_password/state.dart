import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
  @override
  List<Object> get props => [];
}


class ForgotPasswordInitial extends ForgotPasswordState {
  const ForgotPasswordInitial();
  @override
  String toString()  =>  "ForgotPassword Initial";
}

class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  String toString()  =>  "ForgotPassword Loading";
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  //when api call is success then pass the success json response to calling method
  final dynamic jsonResponse;
  const ForgotPasswordSuccess({@required this.jsonResponse}) : assert(jsonResponse != null);
  @override
  List<Object> get props => [jsonResponse];
}


class ForgotPasswordError extends ForgotPasswordState {
  final String error;
  ForgotPasswordError({@required this.error});

  @override
  String toString()  =>  "ForgotPassword Error";

  @override
  List<Object> get props => [error];
}