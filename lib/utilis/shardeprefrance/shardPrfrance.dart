import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefranceData {
  static const String USER_DATA = "userData";
  static const String USER_ISREJESTED = "userIsREjestId";
  static const String USER_EMAIL = "userEmail";
  static const String USER_PASS = "userPass";
  static const String USER_UID = "userUid";
  static const String USER_TOKen = "userToken";

  late SharedPreferences sharedPrefrance;
  static final SharedPrefranceData _data = SharedPrefranceData.instance();
  SharedPrefranceData.instance() {
    loadData();
  }
  factory SharedPrefranceData() {
    return _data;
  }
  Future loadData() async {
    sharedPrefrance = await SharedPreferences.getInstance();
  }
}
