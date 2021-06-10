import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('Bloc On Event --- >');
    print(event);
    super.onEvent(bloc, event);
  }



  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('Bloc On Transition --- >');
    print(transition);
    super.onTransition(bloc, transition);
  }


}