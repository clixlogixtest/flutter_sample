import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';


abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  @override
  List<Object> get props => [];
}


class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
  @override
  String toString()  =>  "Reset Password Initial";
}

class ResetPasswordLoading extends ResetPasswordState {
  @override
  String toString()  =>  "Reset Password Loading";
}

class ResetPasswordSuccess extends ResetPasswordState {
  //when api call is success then pass the success json response to calling method
  final dynamic jsonResponse;
  const ResetPasswordSuccess({@required this.jsonResponse}) : assert(jsonResponse != null);
  @override
  List<Object> get props => [jsonResponse];
}


class ResetPasswordError extends ResetPasswordState {
  final String error;
  ResetPasswordError({@required this.error});

  @override
  String toString()  =>  "Reset Password Error";

  @override
  List<Object> get props => [error];
}