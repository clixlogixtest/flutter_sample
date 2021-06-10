/*
In order to expose all those HTTP errors and exceptions to our UI,
 we are going to create a generic class which encapsulates both the network status and the data coming from the API.
 */

/**
 * To handle all our API responses on the UI thread we’ll need an API response class (not model)
 */

enum Status { LOADING, COMPLETED, ERROR }


class ApiResponse<T> {
  Status status;
  T data;
  String message;

  ApiResponse.loading(this.message) : status = Status.LOADING;
  ApiResponse.completed(this.data) : status = Status.COMPLETED;
  ApiResponse.error(this.message) : status = Status.ERROR;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}

