import '../https/http_urls.dart';

/// A class that holds the base URL for API requests.
class ApiUrls {
  /// The base URL for API requests.
  static String BASE_URL = HttpUrlsEnveiroment().baseUrl!;

  /// The base URL for image requests.
  static String IMAGE_BASE_URL = HttpUrlsEnveiroment().imageBaseUrl!;
}
