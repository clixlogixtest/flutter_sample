import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class SignUpSubmit extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  final String name;

  SignUpSubmit({@required this.email,@required this.password,@required this.confirmPassword,@required this.name});

  @override
  List<Object> get props => [email,password,confirmPassword,name];
}

class SignUpSubmitFinal extends SignUpEvent {
  final String id;
  final String name;
  final String email;
  final String token;

  SignUpSubmitFinal({@required this.id,@required this.name,@required this.email,@required this.token});

  @override
  List<Object> get props => [id,name,email,token];
}


class RegisterWithGoogle extends SignUpEvent {
}

class RegisterWithFacebook extends SignUpEvent {
}
class RegisterWithTwitter extends SignUpEvent {
}