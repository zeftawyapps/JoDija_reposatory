import 'package:JoDija_DataSource/source/http/crud_http_sources.dart';
import 'package:JoDija_DataSource/utilis/json_reader/json_asset_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'https/http_urls.dart';
abstract class DataSourceConfigration {

  Future FirebaseInit(String path) async {
    try {


      WidgetsFlutterBinding.ensureInitialized();

      var data = await JsonAssetReader(path: path).data;
      var firebaseConfig = data['firebaseConfig'];
      if (this.envType == EnvType.prod) {
        var prod = firebaseConfig['prod'];
        await Firebase.initializeApp(
            options: FirebaseOptions(
                apiKey: prod['apiKey'],
                appId: prod['appId'],
                messagingSenderId: prod['messagingSenderId'],
                projectId: prod['projectId'],
                storageBucket: prod['storageBucket']));
      } else {
        var dev = firebaseConfig['dev'];
        await Firebase.initializeApp(
            options: FirebaseOptions(
                apiKey: dev['apiKey'],
                appId: dev['appId'],
                messagingSenderId: dev['messagingSenderId'],
                projectId: dev['projectId'],
                storageBucket: dev['storageBucket']));
      }
    } on Exception catch (e) {
      print(e);
    }
  }


  Future backenRoutsdInit(String path ) async {
    WidgetsFlutterBinding.ensureInitialized();

    var data = await JsonAssetReader(path: "").data;
    var baseUrls = data['baseUrls'];
    String BaseUrl;

    if (backendState == BackendState.local) {
      BaseUrl = baseUrls['local'];
    } else {
      BaseUrl = baseUrls['remote'];
    }
    HttpUrlsEnveiroment(baseUrl: BaseUrl);
  }


  AppType appType = AppType.App;

  BackendState backendState = BackendState.remote;


  EnvType envType = EnvType.dev;



}
enum AppType { DashBord, App }

enum EnvType { localDev, dev, prod }

enum BackendState { local, remote }