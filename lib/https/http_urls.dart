// create class UsersHttpUrls use singleton pattern
/// A singleton class to manage HTTP headers for authentication.
class HttpHeader {
  String _usertoken = '';
  String _contentType = '';
  String _contentTypeKey = '';
  String _tokenKey = '';
  String _tokenType = '';

  /// The singleton instance of the class.
  static final HttpHeader _instance = HttpHeader._internal();

  /// Factory constructor to get the singleton instance.
  factory HttpHeader() => _instance;

  /// Sets the authentication header with the provided token and optional parameters.
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

  // Getters for the private fields.
  String get tokenKey => _tokenKey;
  String get tokenType => _tokenType;
  String get contentTypeKey => _contentTypeKey;
  String get contentType => _contentType;
  String get usertoken => _usertoken;

  /// Internal constructor for singleton pattern.
  HttpHeader._internal();
}
/// A singleton class to manage the environment URLs for HTTP requests.
class HttpUrlsEnveiroment {
  /// The base URL for the HTTP requests.
  String? baseUrl = "https://eventapp-api.herokuapp.com/api/v1";

  /// The singleton instance of the class.
  static final HttpUrlsEnveiroment _baseUrlEnvet =
      HttpUrlsEnveiroment._internal();

  /// Factory constructor to get the singleton instance.
  /// Optionally sets the base URL if provided.
  factory HttpUrlsEnveiroment({String? baseUrl}) {
    if (baseUrl != null) _baseUrlEnvet.baseUrl = baseUrl;

    return _baseUrlEnvet;
  }

  /// Internal constructor for singleton pattern.
  HttpUrlsEnveiroment._internal();

  /// Factory constructor to get the singleton instance.
  /// Optionally sets the base URL if provided.
  factory HttpUrlsEnveiroment.urls({
    String? baseUrl,
  }) {
    _baseUrlEnvet.baseUrl = baseUrl;

    return _baseUrlEnvet;
  }
}