import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:slider_widget/blocs/api/api_bloc.dart';
import 'package:slider_widget/controllers/api_exceptions.dart';
import 'package:slider_widget/controllers/api_repository.dart';
import 'package:slider_widget/utils/storage_helper.dart';


class ApiBloc extends Bloc<ApiEvent,ApiState> {

  final ApiRepository repository = ApiRepository();

  ApiBloc():  super(ApiInitial());



  @override
  ApiState get initialState => ApiInitial();

  @override
  Stream<ApiState> mapEventToState(ApiEvent event) async* {
    //post request
    if (event is ApiPostRequest) {
      try {
        yield ApiInitial();
        yield ApiLoading();

        String url = event.url;
        Map<String,dynamic> parameters = event.formData;

        final  result = await repository.makePostRequest(url,parameters);
        if(result['status'] == 'success'){
          yield ApiSuccess(jsonResponse: result);
        }
        else {
          yield ApiError(error:result['message']);
        }

      }
      on FetchDataException  catch(error){
        yield ApiError(error: error.toString());
      }
      on UnauthorisedException catch(error){
        yield ApiError(error: error.toString());
      }
      catch (error) {
        yield ApiError(error:"Please try again");
      }
    }

    //post request made with token
    else  if (event is ApiPostRequestToken) {
      try {
        yield ApiInitial();
        yield ApiLoading();
        String url = event.url;
        Map<String,dynamic> parameters = event.formData;
        String token = await MySharedPreferences.instance.getStringValue('token');

        if(token.isEmpty)  {
          yield ApiError(error:'Auth Token Not found');
          return;
        }

          final  result = await repository.makePostRequestToken(url,parameters,token);
          if(result['status'] == 'success'){
            yield ApiSuccess(jsonResponse: result);
          }
          else {
            yield ApiError(error:result['message']);
          }

      }
      on FetchDataException  catch(error){
        yield ApiError(error: error.toString());
      }
      on UnauthorisedException catch(error){
        yield ApiError(error: error.toString());
      }
      catch (error) {
        yield ApiError(error:"Please try again");
      }
    }


    //get request
    else  if (event is ApiGetRequest) {
      try {
        yield ApiInitial();
        yield ApiLoading();
        String url = event.url;
        final  result = await repository.makeGetRequest(url);

        if(result['status'] == 'success'){
          yield ApiSuccess(jsonResponse: result);
        }
        else {
          yield ApiError(error:result['message']);
        }
        yield ApiInitial();
      }
      on FetchDataException  catch(error){
        yield ApiError(error: error.toString());
      }
      on UnauthorisedException catch(error){
        yield ApiError(error: error.toString());
      }
      catch (error) {
        yield ApiError(error:"Please try again");
      }
    }

    //get request using token
    else  if (event is ApiGetRequestToken) {
      try {
        yield ApiInitial();
        yield ApiLoading();

        String token = await MySharedPreferences.instance.getStringValue('token');
        if(token.isEmpty)  {
          yield ApiError(error:'Auth Token Not found');
          return;
        }


        String url = event.url;
        final  result = await repository.makeGetRequestToken(url,token);

        if(result['status'] == 'success'){
          yield ApiSuccess(jsonResponse: result);
        }
        else {
          yield ApiError(error:result['message']);
        }

      }
      on FetchDataException  catch(error){
        yield ApiError(error: error.toString());
      }
      on UnauthorisedException catch(error){
        yield ApiError(error: error.toString());
      }
      catch (error) {
        yield ApiError(error:"Please try again");
      }
    }
  }
}


