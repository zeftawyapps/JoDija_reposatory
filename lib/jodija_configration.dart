import 'package:JoDija_DataSource/source/http/crud_http_sources.dart';
import 'package:firebase_core/firebase_core.dart';
abstract class DataSourceConfigration {
    AppType appType = AppType.App;
    EnvType envType = EnvType.dev;
    BackendState backendState = BackendState.remote;

    Future FirebaseInit() ;
  Future backenRoutsdInit() ;


}
enum AppType { DashBord, App }

enum EnvType { localDev, dev, prod }

enum BackendState { local, remote }