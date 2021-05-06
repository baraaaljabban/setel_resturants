
const String RESPONSE_SUCCESS = "SUCCESS";
const String RESPONSE_ERROR = "ERROR";
const int RESPONSE_SUCCESS_CODE = 200;

///class will be used to be as an abstruct for
///to know from the begining if the respons that I got
///has error from the [responseCode] and show the [responseMessage] to the user
class Response {
  final String responseCode;
  final String responseMessage;

  Response({this.responseCode, this.responseMessage});

  // factory Response.fromJson(Map<String, dynamic> json) =>
  //     _$ResponseFromJson(json);
}
