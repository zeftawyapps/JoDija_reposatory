// create class UsersHttpUrls use singleton pattern

class HttpUrlsEnveiroment {
  String? baseUrl = "https://eventapp-api.herokuapp.com/api/v1";

  static final HttpUrlsEnveiroment _baseUrlEnvet =
      HttpUrlsEnveiroment._internal();

  factory HttpUrlsEnveiroment({String? baseUrl}) {
    if (baseUrl != null) _baseUrlEnvet.baseUrl = baseUrl;

    return _baseUrlEnvet;
  }

  HttpUrlsEnveiroment._internal();

  factory HttpUrlsEnveiroment.urls({
    String? baseUrl,

  }) {
    _baseUrlEnvet.baseUrl = baseUrl;


    return _baseUrlEnvet;
  }


}

// create class UsersHttpheader use singleton pattern
class HttpHeader {
  String _usertoken = '';
  String _contentType = '';
  String _contentTypeKey = '';
  String _tokenKey = '';
  String _tokenType = '';
  // create instance UsersHttpheader
  static final HttpHeader _instance = HttpHeader._internal();

  factory HttpHeader() => _instance;
  void setAuthHeader(
    String token, {
    String Bearer = "Bearer",
    String tokenType = "",
    String tokenKey = "Authorization",
  }) {
    _usertoken = Bearer + token;
    _tokenKey = tokenKey;
    _tokenType = tokenType;
    // _contentType = contentType ;
    // _contentTypeKey = contentTypeKey ;
  }

  // getter
  String get tokenKey => _tokenKey;
  String get tokenType => _tokenType;
  String get contentTypeKey => _contentTypeKey;
  String get contentType => _contentType;

  String get usertoken => _usertoken;
  // create UsersHttpheader._internal
  HttpHeader._internal();
}
