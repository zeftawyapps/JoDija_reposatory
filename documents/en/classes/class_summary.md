# Jodija Data Source Module Documentation

This document provides a comprehensive overview of all classes in the Jodija data source module, organized by their roles and relationships.

## Architecture Overview

The Jodija Data Source Module follows a layered architecture:

1. **Repository Layer**: Provides high-level APIs for data operations
2. **Source Layer**: Implements specific data source operations (Firebase, HTTP)
3. **Utility Layer**: Provides lower-level functionality for data operations

## Abstract Interfaces

### Base Data Operations

- [`IBaseDataSourceRepo`](abstract_classes/IBaseDataSourceRepo.md): Abstract repository for data source operations
- [`IBaseSource`](abstract_classes/IBaseSource.md): Abstract interface for basic data source operations
- [`IBaseStream`](abstract_classes/IBaseStream.md): Abstract interface for streaming data
- [`IBaseDataActionsSource`](abstract_classes/IBaseDataActionsSource.md): Abstract interface for data source actions

### Authentication

- [`IBaseAuthentication`](abstract_classes/authentication/IBaseAuthentication.md): Abstract interface for authentication operations
- [`IBaseAccountActions`](abstract_classes/authentication/IBaseAccountActions.md): Abstract interface for account actions
- [`IFirebaseAuthentication`](abstract_classes/authentication/IFirebaseAuthentication.md): Abstract interface for Firebase authentication
- [`IHttpAuthentication`](abstract_classes/authentication/IHttpAuthentication.md): Abstract interface for HTTP authentication

## Implementations

### Repositories

- [`DataSourceRepo`](implementations/DataSourceRepo.md): Repository implementation for data sources
- [`BaseAuthRepo`](implementations/BaseAuthRepo.md): Repository implementation for authentication
- [`BaseProfilRebo`](implementations/BaseProfilRebo.md): Repository implementation for user profiles

### Data Sources

- [`DataSourceFirebaseSource`](implementations/DataSourceFirebaseSource.md): Firebase implementation of data source
- [`StreamFirebaseDataSource`](implementations/StreamFirebaseDataSource.md): Firebase implementation of streaming data
- [`DataSourceDataActionsHttpSources`](implementations/DataSourceDataActionsHttpSources.md): HTTP implementation of data actions

### Authentication Sources

- [`AuthHttpSource`](implementations/AuthHttpSource.md): HTTP implementation of authentication
- [`EmailPassowrdAuthSource`](implementations/EmailPassowrdAuthSource.md): Firebase email/password authentication
- [`GoogleAuthSoucre`](implementations/GoogleAuthSoucre.md): Firebase Google authentication

## Utility Classes

### Firebase Utilities

- [`FirebaseLoadingData`](utils/FirebaseLoadingData.md): Utility for loading data from Firebase
- [`FirestoreAndStorageActions`](utils/FirestoreAndStorageActions.md): Utility for Firestore and Storage actions
- [`FireStoreActions`](utils/FireStoreActions.md): Utility for Firestore actions
- [`StorageActions`](utils/StorageActions.md): Utility for Firebase Storage actions

### HTTP Utilities

- [`JodijaHttpClient`](utils/JodijaHttpClient.md): HTTP client utility
- [`HttpLoadingData`](utils/HttpLoadingData.md): Data structure for HTTP responses

## Class Relationships

### Repository-Source Relationships

- `DataSourceRepo` uses `IBaseDataActionsSource` implementations
- `BaseAuthRepo` uses `IBaseAuthentication` implementations
- `BaseProfilRebo` uses `IBaseAccountActions` implementations

### Interface-Implementation Relationships

- `IBaseDataActionsSource` is implemented by:

  - `DataSourceFirebaseSource`
  - `DataSourceDataActionsHttpSources`

- `IBaseStream` is implemented by:

  - `StreamFirebaseDataSource`

- `IFirebaseAuthentication` is implemented by:

  - `EmailPassowrdAuthSource`
  - `GoogleAuthSoucre`

- `IHttpAuthentication` is implemented by:
  - `AuthHttpSource`

### Utility Usage

- `DataSourceFirebaseSource` uses:

  - `FirebaseLoadingData`
  - `FirestoreAndStorageActions`

- `AuthHttpSource` uses:
  - `JodijaHttpClient`
  - `HttpLoadingData`

## Usage Patterns

### Firebase Data Access Pattern

1. Create a data model that extends `BaseDataModel`
2. Create a `DataSourceFirebaseSource` instance with the model and path
3. Create a `DataSourceRepo` with the source
4. Use the repository to perform CRUD operations

```dart
// Create a source
var source = DataSourceFirebaseSource.insert(
  dataModel: myModel,
  path: 'collection_path'
);

// Create a repository
var repo = DataSourceRepo(inputSource: source);

// Perform operations
var result = await repo.addData();
```

### HTTP Data Access Pattern

1. Create a data model that extends `BaseDataModel`
2. Create a `DataSourceDataActionsHttpSources` instance with the model and URL
3. Create a `DataSourceRepo` with the source
4. Use the repository to perform CRUD operations

```dart
// Create a source
var source = DataSourceDataActionsHttpSources.inputs(
  dataModyle: myModel,
  url: 'api/endpoint'
);

// Create a repository
var repo = DataSourceRepo(inputSource: source);

// Perform operations
var result = await repo.addData();
```

### Authentication Pattern

1. Create an authentication source (Firebase or HTTP)
2. Create a `BaseAuthRepo` with the source
3. Use the repository for authentication operations

```dart
// Create an authentication source
var authSource = EmailPassowrdAuthSource(
  email: 'user@example.com',
  password: 'password123'
);

// Create a repository
var authRepo = BaseAuthRepo(authSource);

// Perform authentication
var result = await authRepo.logIn();
```

## Conclusion

The Jodija Data Source Module provides a flexible and extensible architecture for data operations. By separating interfaces from implementations, it allows for easy switching between data sources (Firebase, HTTP) without changing the application logic.
