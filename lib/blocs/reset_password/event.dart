import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class ResetPasswordSubmit extends ResetPasswordEvent {
  final String email;
  final String password;
  final String confirmPassword;

  ResetPasswordSubmit({@required this.email,@required this.password,@required this.confirmPassword});

  @override
  List<Object> get props => [email,password,confirmPassword];
}