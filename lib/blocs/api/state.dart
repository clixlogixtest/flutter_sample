import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:slider_widget/models/user.dart';


abstract class ApiState extends Equatable {
  const ApiState();
  @override
  List<Object> get props => [];
}


class ApiInitial extends ApiState {
  const ApiInitial();
  @override
  String toString()  =>  "Api Initial";
}

class ApiLoading extends ApiState {
  @override
  String toString()  =>  "Api Loading";
}

class ApiSuccess extends ApiState {
  //when api call is success then pass the success json response to calling method
  final dynamic jsonResponse;
  const ApiSuccess({@required this.jsonResponse}) : assert(jsonResponse != null);
  @override
  List<Object> get props => [jsonResponse];
}




class ApiError extends ApiState {
  final String error;
  ApiError({@required this.error});

  @override
  String toString()  =>  "Api Error";

  @override
  List<Object> get props => [error];
}