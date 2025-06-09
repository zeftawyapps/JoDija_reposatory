
import 'i_http_urls.dart';
/// A singleton class that provides base URLs for product-related HTTP requests.
class ProductBaseUrls extends HttpUrls {
  // Singleton instance of ProductBaseUrls
  static final ProductBaseUrls _instance = ProductBaseUrls._internal();

  /// URL for adding a product
  String addPruductUrl = 'v1/products';

  /// URL for editing a product
  String editPruductUrl = 'v1/products';

  /// Constructor with optional parameters for URLs
  ProductBaseUrls({this.addPruductUrl = 'v1/products', this.editPruductUrl = 'v1/products'}) {
    _instance;
  }

  /// Internal named constructor for singleton pattern
  ProductBaseUrls._internal();
}