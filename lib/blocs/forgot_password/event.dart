import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ForgotPasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}


class ForgotPasswordSubmit extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordSubmit({@required this.email});

  @override
  List<Object> get props => [email];
}