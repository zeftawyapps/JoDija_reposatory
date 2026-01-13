import 'package:dio/dio.dart';

import '../../../../constes/api_urls.dart';
import '../../../../interface/user/http_acc.dart';
import '../../../../model/user/base_model/base_user_module.dart';
import '../../../../utilis/http_remotes/http_client.dart';
import '../../../../utilis/http_remotes/http_methos_enum.dart';
import '../../../../utilis/models/staus_model.dart';


/// HTTP-based implementation of authentication source.
/// 
/// This class provides authentication operations using HTTP requests,
/// including user registration, login, logout, and password change functionality.
/// It follows the same pattern as DataSourceDataActionsHttpSources for consistency.
class AuthHttpSource implements IHttpAuthentication {
  /// The user's email address
  String? email;
  
  /// The user's password
  String? pass;
  
  /// The user's name (optional)
  String? name;
  
  /// The base URL for API requests (defaults to ApiUrls.BASE_URL)
  String baseUrl = "";
  
  /// The endpoint URL for login operations (default: "login")
  String loginUrl = "";
  
  /// The endpoint URL for account creation (default: "register")
  String createAccountUrl = "";
  
  /// The endpoint URL for logout operations (default: "logout")
  String logoutUrl = "";
  
  /// The endpoint URL for password change operations (default: "change-password")
  String changePasswordUrl = "";

  /// Factory constructor for creating an AuthHttpSource instance with configurable endpoints.
  /// 
  /// This is the recommended way to create an instance, allowing customization of all endpoints.
  /// 
  /// Parameters:
  /// - [baseUrl]: The base URL for API requests. Defaults to empty string (will use ApiUrls.BASE_URL)
  /// - [email]: The user's email address (required)
  /// - [pass]: The user's password (required)
  /// - [loginUrl]: Custom endpoint for login (optional, defaults to "login")
  /// - [createAccountUrl]: Custom endpoint for registration (optional, defaults to "register")
  /// - [logoutUrl]: Custom endpoint for logout (optional, defaults to "logout")
  /// - [changePasswordUrl]: Custom endpoint for password change (optional, defaults to "change-password")
  /// 
  /// Example:
  /// ```dart
  /// var auth = AuthHttpSource.inputs(
  ///   baseUrl: "https://api.myapp.com",
  ///   email: "user@example.com",
  ///   pass: "password123",
  ///   loginUrl: "auth/login"
  /// );
  /// ```
  factory AuthHttpSource.inputs({
    String? baseUrl = "", 
    required String email, 
    required String pass,
    String? loginUrl,
    String? createAccountUrl,
    String? logoutUrl,
    String? changePasswordUrl,
  }) {
    return AuthHttpSource(
      baseUrl: baseUrl, 
      email: email, 
      pass: pass,
      loginUrl: loginUrl,
      createAccountUrl: createAccountUrl,
      logoutUrl: logoutUrl,
      changePasswordUrl: changePasswordUrl,
    )
      ..email = email
      ..pass = pass;
  }

  /// Constructor for creating an AuthHttpSource instance.
  /// 
  /// Initializes the authentication source with user credentials and configurable endpoints.
  /// Use the factory constructor [AuthHttpSource.inputs] for a more fluent interface.
  /// 
  /// Parameters:
  /// - [baseUrl]: The base URL for API requests (defaults to ApiUrls.BASE_URL if null)
  /// - [email]: The user's email address (required)
  /// - [pass]: The user's password (required)
  /// - [loginUrl]: Custom endpoint for login (defaults to "login")
  /// - [createAccountUrl]: Custom endpoint for registration (defaults to "register")
  /// - [logoutUrl]: Custom endpoint for logout (defaults to "logout")
  /// - [changePasswordUrl]: Custom endpoint for password change (defaults to "change-password")
  AuthHttpSource({
    String? baseUrl = "", 
    required String email, 
    required String pass,
    String? loginUrl,
    String? createAccountUrl,
    String? logoutUrl,
    String? changePasswordUrl,
  }) {
    this.baseUrl = baseUrl ?? ApiUrls.BASE_URL;
    this.email = email;
    this.pass = pass;
    this.loginUrl = loginUrl ?? "login";
    this.createAccountUrl = createAccountUrl ?? "register";
    this.logoutUrl = logoutUrl ?? "logout";
    this.changePasswordUrl = changePasswordUrl ?? "change-password";
  }
  
  /// Creates a new user account via HTTP POST request.
  /// 
  /// This method sends a POST request to the registration endpoint with the user's
  /// email, password, and any additional data provided in the [body] parameter.
  /// 
  /// Parameters:
  /// - [body]: Optional map containing additional user data to be sent with the request
  /// 
  /// Returns:
  /// - A [Future] that completes with a [UsersBaseModel] containing the created user's data
  /// 
  /// Throws:
  /// - [Exception] if the request fails or returns a non-success status
  /// 
  /// Example:
  /// ```dart
  /// var user = await authSource.createAccount(
  ///   body: {"name": "John Doe", "phone": "+1234567890"}
  /// );
  /// ```
  @override
  Future<UsersBaseModel> createAccount({Map<String , dynamic >? body  }) async {
    Map<String , dynamic > allBody = {"email": email , "password": pass};
    if (body != null) {
      allBody.addAll(body);
    }
    
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: baseUrl + "/" + createAccountUrl,
        body: allBody,
        cancelToken: CancelToken());
    
    if (result.data!.status == StatusModel.success) {
      var data = result.data!.data!["data"];
      return UsersBaseModel.formJson(data);
    } else {
      throw Exception(result.data!.message);
    }
  }

  /// Authenticates a user via HTTP POST request.
  /// 
  /// This method sends a POST request to the login endpoint with the user's
  /// email and password. On successful authentication, it returns user data
  /// including the authentication token.
  /// 
  /// Returns:
  /// - A [Future] that completes with a [UsersBaseModel] containing the authenticated
  ///   user's data and authentication token
  /// 
  /// Throws:
  /// - [Exception] if the login fails or returns a non-success status
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   var user = await authSource.logIn();
  ///   print("Logged in with token: ${user.token}");
  /// } catch (e) {
  ///   print("Login failed: $e");
  /// }
  /// ```
  @override
  Future<UsersBaseModel> logIn() async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: baseUrl + "/" + loginUrl,
        body: {"email": email , "password": pass},
        cancelToken: CancelToken());

    if (result.data!.status == StatusModel.success) {
      var data = result.data!.data!["data"];
      Map<String, dynamic> userData = {};
      userData["email"] = email;
      userData["token"] = data["token"];
      userData.addAll(data);
      
      return UsersBaseModel.formJson(userData);
    } else {
      throw Exception(result.data!.message);
    }
  }

  /// Logs out the current user via HTTP POST request.
  /// 
  /// This method sends a POST request to the logout endpoint to end the user's session.
  /// It uses the stored email and password for authentication.
  /// 
  /// Returns:
  /// - A [Future] that completes when the logout operation is successful
  /// 
  /// Throws:
  /// - [Exception] if the logout fails or returns a non-success status
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   await authSource.logOut();
  ///   print("Successfully logged out");
  /// } catch (e) {
  ///   print("Logout failed: $e");
  /// }
  /// ```
  @override
  Future<void> logOut() async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: baseUrl + "/" + logoutUrl,
        body: {"email": email , "password": pass},
        cancelToken: CancelToken());
    
    if (result.data!.status != StatusModel.success) {
      throw Exception(result.data!.message);
    }
  }
  
  /// Changes the user's password via HTTP POST request.
  /// 
  /// This method sends a POST request to the change password endpoint with the
  /// user's email, old password, and new password. The user is authenticated
  /// using the old password before the change is applied.
  /// 
  /// Parameters:
  /// - [email]: The email address of the user whose password is being changed
  /// - [oldPassword]: The user's current password (required for authentication)
  /// - [newPassword]: The new password to set for the user account
  /// 
  /// Returns:
  /// - A [Future] that completes with a [UsersBaseModel] containing the updated user data
  /// 
  /// Throws:
  /// - [Exception] if the password change fails, old password is incorrect,
  ///   or returns a non-success status
  /// 
  /// Example:
  /// ```dart
  /// try {
  ///   var user = await authSource.changePassword(
  ///     "user@example.com",
  ///     "oldPassword123",
  ///     "newPassword456"
  ///   );
  ///   print("Password changed successfully");
  /// } catch (e) {
  ///   print("Password change failed: $e");
  /// }
  /// ```
  @override
  Future<UsersBaseModel> changePassword(String email, String oldPassword, String newPassword) async {
    var result = await HttpClient(userToken: true).sendRequest(
        method: HttpMethod.POST,
        url: baseUrl + "/" + changePasswordUrl,
        body: {
          "email": email,
          "oldPassword": oldPassword,
          "newPassword": newPassword
        },
        cancelToken: CancelToken());
    
    if (result.data!.status == StatusModel.success) {
      var data = result.data!.data!["data"];
      return UsersBaseModel.formJson(data);
    } else {
      throw Exception(result.data!.message);
    }
  }
}
