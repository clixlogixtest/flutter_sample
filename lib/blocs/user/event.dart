import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:slider_widget/models/models.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserLoggedIn extends UserEvent {
  final User user;
  UserLoggedIn({@required this.user});

  @override
  List<Object> get props => [user];
}

class UserDetailsChanged extends UserEvent {
  final User user;
  UserDetailsChanged({@required this.user});

  @override
  List<Object> get props => [user];
}


class UserLoggedOut extends UserEvent {
  UserLoggedOut();
  @override
  List<Object> get props => [];
}

