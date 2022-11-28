class Pair<T1, T2> {
  final T1 content;
  final T2 success;

  Pair(this.content, this.success);
}

class RequestResponse<T1> {
  T1 content;
  int code;

  RequestResponse(this.content, this.code);
}

class Trio<T1, T2, T3> {
  final T1 content;
  final T2 success;
  final T3 errorMessage;

  Trio(this.content, this.success, this.errorMessage);
}
