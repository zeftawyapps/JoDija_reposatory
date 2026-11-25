import 'package:flutter/material.dart';
import 'package:jodija_repository/jodija_repository.dart';

class AppConfiguration extends DataSourceConfigration {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Configure HTTP base URLs for the target environment
  final config = AppConfiguration()
    ..envType = EnvType.dev
    ..backendState = BackendState.remote_dev
    ..appType = AppType.App;

  config.setToHttpUrlsEnveiroment(
    baseUrl: 'https://api.example.com/api/v1',
    imageBaseUrl: 'https://cdn.example.com/',
  );

  // 2. Configure default language and authorization headers
  HttpHeader().setLangHeader(lang: 'en');
  HttpHeader().setAuthHeader('demo-jwt-token');

  JDRepoConsole.success('jodija_repository initialized successfully');

  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final result = Result<RemoteBaseModel, String>.data(
      'Base URL: ${ApiUrls.BASE_URL}',
    );

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('JoDija Repository Example')),
        body: Center(
          child: Text(result.data ?? 'No data'),
        ),
      ),
    );
  }
}
