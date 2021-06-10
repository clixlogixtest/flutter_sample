import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:slider_widget/models/models.dart';


class UserState  extends Equatable {
  final User user;

  UserState({
    this.user 
  });

  @override
  List<Object> get props => [user];
}
