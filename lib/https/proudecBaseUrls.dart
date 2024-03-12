
import 'i_http_urls.dart';

class ProductBaseUrls extends HttpUrls {
  // create instance UsersHttpUrls
  static final ProductBaseUrls _instance = ProductBaseUrls._internal();

  String addPruductUrl = 'v1/products';
  String editPruductUrl = 'v1/products';

  ProductBaseUrls({this.addPruductUrl = 'v1/products' , this.editPruductUrl = 'v1/products'}) {
      _instance;
  }
  ProductBaseUrls._internal();


}