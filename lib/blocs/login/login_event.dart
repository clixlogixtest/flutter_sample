import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class LoginEmailChanged extends LoginEvent {
  final String email;

  LoginEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];
}

class LoginWithSocial extends LoginEvent {
  final String socialtype; //one of: “google”, “twitter”, “facebook” or “apple”
  final String socialid;
  final String socialtoken;
  final String socialdata = '';

  LoginWithSocial({@required this.socialtype, @required this.socialid,@required this.socialtoken });

  @override
  List<Object> get props => [socialtype, socialid , socialtoken , socialdata] ;
}



class LoginInWithEmailButtonPressed extends LoginEvent {
  final String email;
  final String password;


  LoginInWithEmailButtonPressed({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}


class LoginWithGoogle extends LoginEvent {
 }

class LoginWithFacebook extends LoginEvent {
}

class LoginWithTwitter extends LoginEvent {
}
