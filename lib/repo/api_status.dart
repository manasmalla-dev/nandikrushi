//Succuss
class Success{
  int? code;
  Object? response;
  Success({this.code, this.response});
}

//Failure
class Failure{
  int? code;
  String? errorResponse;
  Failure({this.code, this.errorResponse});
}

//pending
class Pending{
  int? code;
  String? pendingResponse;
  Pending({this.code, this.pendingResponse});
}