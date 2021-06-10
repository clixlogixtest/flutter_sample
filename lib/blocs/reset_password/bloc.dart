import 'package:bloc/bloc.dart';
import 'package:slider_widget/blocs/forgot_password/event.dart';
import 'package:slider_widget/blocs/forgot_password/forgot_password_bloc.dart';
import 'package:slider_widget/blocs/reset_password/event.dart';
import 'package:slider_widget/blocs/reset_password/reset_password_bloc.dart';
import 'package:slider_widget/blocs/user/bloc.dart';
import 'package:slider_widget/blocs/user/event.dart';
import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:slider_widget/controllers/api_repository.dart';
import 'package:slider_widget/models/models.dart';
import 'package:slider_widget/utils/storage_helper.dart';
import 'package:slider_widget/utils/validation_mixin.dart';
import '../blocs.dart';
import 'dart:io' show Platform;

class ResetPasswordBloc extends Bloc<ResetPasswordEvent,ResetPasswordState> {
  final repository = ApiRepository();


  ResetPasswordBloc(): super(ResetPasswordInitial());


  @override
  Stream<ResetPasswordState> mapEventToState(ResetPasswordEvent event) async* {
    if (event is ResetPasswordSubmit) {
      yield* _mapResetSubmit(event);
    }

  }

  Stream<ResetPasswordState> _mapResetSubmit(ResetPasswordSubmit event) async* {

    yield ResetPasswordLoading();

    try {
      if (true) {
        final  result = await repository.postResetPassword(event.email,event.password,event.confirmPassword);
        if(result['reset'])  yield ResetPasswordSuccess(jsonResponse: result);
        else  yield ResetPasswordError(error: result['error'].toString());

        yield ResetPasswordInitial();
      } else {
        yield ResetPasswordError(error: 'Something very weird just happened');
      }
    } on FetchDataException catch (e) {
      yield ResetPasswordError(error:e.toString());
    } catch (err) {
      yield ResetPasswordError(error: err.message ?? 'An unknown error occured');
    }
  }




}
