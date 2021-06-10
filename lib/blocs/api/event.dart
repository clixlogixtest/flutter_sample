import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';


abstract class ApiEvent extends Equatable {
  const ApiEvent();
}

//class used to make a post request
class ApiPostRequest extends ApiEvent {
  final Map<String,dynamic> formData;
  final String url;
  ApiPostRequest({@required this.url,@required this.formData});

  @override
  List<Object> get props => [url,formData];
}


//class used to make a post request using token
class ApiPostRequestToken extends ApiEvent {
  final Map<String,dynamic> formData;
  final String url;
  ApiPostRequestToken({@required this.url,@required this.formData});

  @override
  List<Object> get props => [url,formData];
}

//class used to make a get request using token
class ApiGetRequestToken extends ApiEvent {
  final String url;
  ApiGetRequestToken({@required this.url});

  @override
  List<Object> get props => [url];
}


//class used to make a get request
class ApiGetRequest extends ApiEvent {
  final String url;
  ApiGetRequest({@required this.url});

  @override
  List<Object> get props => [url];
}

