import 'package:bloc/bloc.dart';
import 'package:slider_widget/blocs/forgot_password/event.dart';
import 'package:slider_widget/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:slider_widget/controllers/api_repository.dart';
import 'package:slider_widget/models/models.dart';
import 'package:slider_widget/utils/storage_helper.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import '../blocs.dart';
import 'dart:io' show Platform;

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final repository = ApiRepository();


  ForgotPasswordBloc(): super(ForgotPasswordInitial());


  @override
  Stream<ForgotPasswordState> mapEventToState(ForgotPasswordEvent event) async* {
    if (event is ForgotPasswordSubmit) {
      yield* _mapLoginWithEmailToState(event);
    }

  }

  Stream<ForgotPasswordState> _mapLoginWithEmailToState(ForgotPasswordSubmit event) async* {

    yield ForgotPasswordLoading();

    try {
      if (true) {
        String email = event.email;
        final  result = await repository.postForgotPassword(email);
        if(result['sent'])  yield ForgotPasswordSuccess(jsonResponse: result);
        else  yield ForgotPasswordError(error: result['error'].toString());

        yield ForgotPasswordInitial();
      } else {
        yield ForgotPasswordError(error: 'Something very weird just happened');
      }
    } on FetchDataException catch (e) {
      yield ForgotPasswordError(error:e.toString());
    } catch (err) {
      yield ForgotPasswordError(error: err.message ?? 'An unknown error occured');
    }
  }




}
