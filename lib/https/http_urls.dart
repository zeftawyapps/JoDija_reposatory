// create class UsersHttpUrls use singleton pattern
/// A singleton class to manage HTTP headers for authentication.
class HttpHeader {
  String _usertoken = '';
  String _contentType = '';
  String _contentTypeKey = '';
  String _tokenKey = '';
  String _tokenType = '';
  String _langKey = 'x-lang';
  String? _langValue;

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

  /// Sets the language header.
  /// 
  /// [lang] is the language value (e.g., 'ar', 'en'). Can be null.
  /// [key] is the header key, defaults to 'x-lang'.
  void setLangHeader({
    String? lang,
    String key = "x-lang",
  }) {
    _langValue = lang;
    _langKey = key;
  }

  // Getters for the private fields.
  String get tokenKey => _tokenKey;
  String get tokenType => _tokenType;
  String get contentTypeKey => _contentTypeKey;
  String get contentType => _contentType;
  String get usertoken => _usertoken;
  String get langKey => _langKey;
  String? get langValue => _langValue;

  /// Internal constructor for singleton pattern.
  HttpHeader._internal();
}

class HttpUrlsEnveiroment {
  /// The base URL for the HTTP requests.
  String? baseUrl = "https://eventapp-api.herokuapp.com/api/v1";
  String? imageBaseUrl = "https://eventapp-api.herokuapp.com/api/v1";

  /// The singleton instance of the class.
  static final HttpUrlsEnveiroment _baseUrlEnvet =
      HttpUrlsEnveiroment._internal();

  /// Factory constructor to get the singleton instance.
  /// Optionally sets the base URL if provided.
  factory HttpUrlsEnveiroment({String? baseUrl, String? imageBaseUrl}) {
    if (baseUrl != null) _baseUrlEnvet.baseUrl = baseUrl;
    if (imageBaseUrl != null) _baseUrlEnvet.imageBaseUrl = imageBaseUrl;

    return _baseUrlEnvet;
  }

  /// Internal constructor for singleton pattern.
  HttpUrlsEnveiroment._internal();

  /// Factory constructor to get the singleton instance.
  /// Optionally sets the base URL if provided.
  factory HttpUrlsEnveiroment.urls({
    String? baseUrl,
    String? imageBaseUrl,
  }) {
    if (baseUrl != null) _baseUrlEnvet.baseUrl = baseUrl;
    if (imageBaseUrl != null) _baseUrlEnvet.imageBaseUrl = imageBaseUrl;

    return _baseUrlEnvet;
  }
}
