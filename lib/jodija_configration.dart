import 'package:JoDija_reposatory/utilis/json_reader/json_asset_reader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import 'https/http_urls.dart';

/// Abstract class for configuring data sources, including Firebase and backend routing.
///
/// This class provides methods to initialize Firebase and backend routing configurations
/// from JSON files or data maps. It also includes properties to manage the application type,
/// backend state, and environment type.
abstract class DataSourceConfigration {
  /// Initializes Firebase with the configuration specified in the JSON file at the given path.
  ///
  /// This function reads the Firebase configuration from a JSON file and initializes Firebase
  /// based on the environment type (production or development).
  ///
  /// \[param\] path The path to the JSON file containing the Firebase configuration.
  /// \[throws\] Exception if an error occurs during Firebase initialization.
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

  /// Initializes Firebase with the configuration provided in the given data map.
  ///
  /// This function initializes Firebase based on the environment type (production or development)
  /// using the configuration provided in the data map.
  ///
  /// \[param\] path The map containing the Firebase configuration.
  /// \[throws\] Exception if an error occurs during Firebase initialization.
  Future FirebaseInitFromDataJson(Map<String, dynamic> path) async {
    try {
      WidgetsFlutterBinding.ensureInitialized();

      var data = path;
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

  /// Initializes the backend routing with the base URL specified in the JSON file at the given path.
  ///
  /// This function reads the base URLs from a JSON file and sets the base URL
  /// based on the backend state (local, remote\_dev, or remote\_prod).
  ///
  /// \[param\] path The path to the JSON file containing the base URLs.
  /// \[throws\] Exception if an error occurs during the initialization.
  Future backendRoutedInit(String path) async {
    WidgetsFlutterBinding.ensureInitialized();

    var data = await JsonAssetReader(path: path).data;
    var baseUrls = data['baseUrls'];
    String BaseUrl;

    if (backendState == BackendState.local) {
      BaseUrl = baseUrls['local'];
    } else if (backendState == BackendState.remote_dev) {
      BaseUrl = baseUrls['remote_dev'];
    } else {
      BaseUrl = baseUrls['remote_prod'];
    }
    HttpUrlsEnveiroment(baseUrl: BaseUrl);
  }

  /// Initializes the backend routing with the base URL provided in the given data map.
  ///
  /// This function reads the base URLs from the provided data map and sets the base URL
  /// based on the backend state (local, remote\_dev, or remote\_prod).
  ///
  /// \[param\] data The map containing the base URLs.
  /// \[throws\] Exception if an error occurs during the initialization.
  Future backendRoutedInitFromJson(Map<String, dynamic> data) async {
    WidgetsFlutterBinding.ensureInitialized();

    var baseUrls = data['baseUrls'];
    String BaseUrl;

    if (backendState == BackendState.local) {
      BaseUrl = baseUrls['local'];
    } else if (backendState == BackendState.remote_dev) {
      BaseUrl = baseUrls['remote_dev'];
    } else {
      BaseUrl = baseUrls['remote_prod'];
    }
    HttpUrlsEnveiroment(baseUrl: BaseUrl);
  }

  AppType _appType = AppType.App;

  BackendState _backendState = BackendState.remote_dev;

  EnvType _envType = EnvType.dev;

  AppType get appType => _appType;
  set appType(AppType value) {
    _appType = value;
  }

  BackendState get backendState => _backendState;
  set backendState(BackendState value) {
    _backendState = value;
  }

  EnvType get envType => _envType;
  set envType(EnvType value) {
    _envType = value;
  }
}

enum AppType { DashBord, App }

enum EnvType { localDev, dev, prod }

enum BackendState { local, remote_dev, remote_prod }
