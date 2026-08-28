# Jodija Data Source Module Documentation

This document provides a comprehensive overview of all classes in the Jodija Repository module, organized by their architectural roles and relationships.

---

## Architecture Overview

The Jodija Repository follows a layered architecture:

1. **Repository Layer**: Provides high-level APIs for business logic operations and UI consumption.
2. **Source / Connector Layer**: Implements specific data source operations (Firebase Firestore/Storage, HTTP REST API).
3. **Utility Layer**: Low-level networking, headers, logging, and error mapping functionality.

---

## 1. Abstract Interfaces

### Base Data Operations
- [`IBaseDataSourceRepo`](abstract_classes/IBaseDataSourceRepo.md): Abstract repository for CRUD data source operations.
- [`IBaseSource`](abstract_classes/IBaseSource.md): Abstract interface for basic data source operations.
- [`IBaseStream`](abstract_classes/IBaseStream.md): Abstract interface for real-time streaming data.
- [`IBaseDataActionsSource`](abstract_classes/IBaseDataActionsSource.md): Abstract interface for data source mutations.
- [`IBaseLoadSource`](implementations/LoadDataRepo.md): Abstract interface for loading entity lists.

### Authentication & Users
- [`IBaseAuthentication`](abstract_classes/authentication/IBaseAuthentication.md): Abstract interface for authentication operations.
- [`IBaseAccountActions`](abstract_classes/authentication/IBaseAccountActions.md): Abstract interface for account profile actions.
- [`IFirebaseAuthentication`](abstract_classes/authentication/IFirebaseAuthentication.md): Firebase-specific authentication interface.
- [`IHttpAuthentication`](abstract_classes/authentication/IHttpAuthentication.md): HTTP-specific authentication interface.

---

## 2. Implementations

### Repositories
- [`DataSourceRepo`](implementations/DataSourceRepo.md): Standard CRUD repository implementation.
- [`LoadDataRepo`](implementations/LoadDataRepo.md): Repository for fetching collections/lists of entities.
- [`BaseAuthRepo`](implementations/BaseAuthRepo.md): Repository implementation for user login and signup.
- [`BaseUsersRepo`](implementations/UsersRepo.md): Repository for managing users and user listings.
- [`BaseProfilRebo`](implementations/BaseProfilRebo.md): Repository for managing the active user profile.

### Data Sources & Connectors
- [`DataSourceFirebaseSource`](implementations/DataSourceFirebaseSource.md): Firebase Firestore & Storage CRUD connector.
- [`StreamFirebaseDataSource`](implementations/StreamFirebaseDataSource.md): Firebase Firestore real-time stream connector.
- [`DataSourceDataActionsHttpSources`](implementations/DataSourceDataActionsHttpSources.md): HTTP REST API CRUD connector.
- [`LoadDataHttpSources`](implementations/LoadDataRepo.md): HTTP REST API list-fetching connector.

### Authentication Sources
- [`AuthHttpSource`](implementations/AuthHttpSource.md): HTTP implementation of authentication.
- [`EmailPassowrdAuthSource`](implementations/EmailPassowrdAuthSource.md): Firebase Email/Password authentication.
- [`GoogleAuthSoucre`](implementations/GoogleAuthSoucre.md): Firebase Google Sign-In authentication.
- [`BaseUsersActionsSources`](implementations/UsersRepo.md): Firebase user management actions source.
- [`ProfileActions`](implementations/UsersRepo.md): Firebase user profile mutation actions source.

---

## 3. Configuration & Utilities

### Configuration
- [`DataSourceConfiguration`](configration.md): Manages environments (`EnvType`), backend routing (`BackendState`), `baseUrls`, `imageBaseUrls`, and Firebase setup.

### Networking & HTTP Utilities
- [`HttpClient`](utils/JodijaHttpClient.md): Dio-based HTTP client supporting GET, POST, PUT, DELETE, and PATCH with automatic error parsing.
- [`HttpHeader`](utils/HttpHeader.md): Singleton manager for JWT tokens and `x-lang` localization headers.
- [`HttpLoadingData`](utils/HttpLoadingData.md): Response wrapper for HTTP operations.
- [`HttpErrors`](utils/HttpErrors.md): Hierarchy of typed errors (`BadRequestError`, `UnauthorizedError`, `InternalServerError`, etc.).

### Logging & Diagnostics
- [`JDRepoConsole`](utils/JDRepoConsole.md): Centralized, colorized logging utility with `LogContext`, `LogLevel`, and performance metrics.

### Firebase Utilities
- [`FirebaseLoadingData`](utils/FirebaseLoadingData.md): Utility for reading data from Firebase Firestore.
- [`FirestoreAndStorageActions`](utils/FirestoreAndStorageActions.md): Combined Firestore and Storage actions.
- [`FireStoreActions`](utils/FireStoreActions.md): Firestore document and collection operations.
- [`StorageActions`](utils/StorageActions.md): Firebase Storage file and image upload helper.
- [`FCMService`](utils/FCMService.md): Firebase Cloud Messaging notification service.

---

## 4. Models & Results

- [`BaseEntityDataModel`](base_model/base_data_model.md): Root entity model class.
- [`RemoteBaseModel`](base_model/remote_base_model.md): Standard model for API responses.
- [`Result`](results/result.md): Generic result container (`Result<Error, Data>`).
- [`UserResult`](results/result_user_data.md): User-specific result container.
- [`Cell Models`](base_model/cell_models.md): `Cell<T>`, `RowofCells<T>`, and `TableOfCells<T>`.

---

## Usage Patterns

### Multi-Solution Pattern (`matger front logic`)

```dart
// 1. Initialize shared logic config in App
await MatgerLogicConfiguration().initializeApp(
  configAssetPath: 'assets/config/config.json',
  env: EnvType.dev,
  backend: BackendState.remote_dev,
  app: AppType.App,
  defaultLanguage: 'ar',
);

// 2. Perform CRUD operations via Repository
var source = DataSourceDataActionsHttpSources<ProductModel>.inputs(
  dataModyle: newProduct,
  url: 'products',
);
var repo = DataSourceRepo(inputSource: source);
var result = await repo.addData();
```
