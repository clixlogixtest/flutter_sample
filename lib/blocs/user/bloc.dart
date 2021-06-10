import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slider_widget/blocs/api/api_bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/blocs/user/state.dart';
import 'package:slider_widget/models/models.dart';



class UserBloc extends Bloc<UserEvent,UserState> {

  UserBloc():  super(UserState());

  @override
  UserState get initialState => UserState();

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserLoggedIn) {
      yield* _mapUserLoggedIn(event);
    }
    else if (event is UserDetailsChanged) {
      yield* _mapUserDetailsChanged(event);
    }
    else if (event is UserLoggedOut) {
      yield* _mapUserLoggedOut(event);
    }
  }


  Stream<UserState> _mapUserLoggedIn(UserLoggedIn event) async* {
    yield UserState(user : event.user);

  }
  Stream<UserState> _mapUserDetailsChanged(UserDetailsChanged event) async* {
    yield UserState(user:event.user);
  }

  Stream<UserState> _mapUserLoggedOut(UserLoggedOut event) async* {
    yield UserState(user:null);
  }
}






