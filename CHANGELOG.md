## 1.7.2

* Rewrote `README.md` and `README.ar.md` with clear architecture diagrams, end-to-end Dart usage examples (Models, REST CRUD, Dio `HttpClient`, Firestore, Authentication), and direct GitHub documentation links compatible with `pub.dev`.

## 1.7.1

* Added full **Web & Wasm** compatibility by replacing unconditional `dart:io` imports with conditional imports (`if (dart.library.io)`) and declaring all 6 supported Flutter platforms (`android`, `ios`, `linux`, `macos`, `web`, `windows`) in `pubspec.yaml`.

## 1.7.0

* Prepared package for `pub.dev` publication under the name `jodija_repository`.
* Multi-environment configuration engine (`DataSourceConfigration`) supporting `local`, `remote_dev`, and `remote_prod` routing with JSON asset initialization.
* Advanced Dio-based `HttpClient` supporting `GET`, `POST`, `PUT`, `DELETE`, `PATCH`, multipart uploads, dynamic `x-lang` headers, and JWT Bearer token headers.
* Strongly-typed HTTP error hierarchy (`BaseError` and subclasses) with `Result` and `UserResult` encapsulations.
* Firebase ecosystem integration for Firestore CRUD/streaming, Firebase Storage, Email/Password & Google Sign-In authentication, and FCM notifications.
* Structured console logging and profiling via `JDRepoConsole` and dynamic table/cell models.
* Upgraded dependencies for latest Flutter/Dart compatibility: removed unused direct dependencies (`flutter_bloc`, `intl`, `dartz`, `firebase_auth_web`, `firebase_core_web`, `freezed_annotation`), migrated `GoogleAuthSoucre` to `google_sign_in` v7, widened Firebase constraints (`firebase_core >=3.4.1 <6.0.0`, etc.), and updated `flutter_lints` to `^6.0.0`.
* Added `jodija_repository.dart` barrel export, `example/` project, and static analysis cleanup.

## 0.0.1

* Initial repository architecture setup.
