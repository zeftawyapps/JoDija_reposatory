# Jodija Repository

## Overview

Jodija Repository is a Flutter data management library that handles data flow between your application and backend services like REST APIs or Firebase. It standardizes the way data is processed: transforming incoming server data to match your application's business logic and formatting outgoing data as JSON for server communication.

## Architecture

Jodija uses a three-layer architecture that promotes separation of concerns, testability, and maintainability:

```
┌─────────────────────────────────────────────────────────────┐
│                    Application Business Logic               │
│          (View Models, Use Cases, State Management)         │
└───────────────────────────┬─────────────────────────────────┘
                           │
                           │ Data requests/responses
                           ▼
┌─────────────────────────────────────────────────────────────┐
│                     Repository Layer                        │
│                                                             │
│  ┌─────────────────┐  ┌─────────────────┐  ┌──────────────┐ │
│  │  AuthRepository │  │ ProfileRepository│  │ DataRepository│ │
│  └────────┬────────┘  └────────┬────────┘  └───────┬──────┘ │
└──────────┬────────────────────┬────────────────────┬────────┘
           │                    │                    │
           │                    │                    │
┌──────────┼────────────────────┼────────────────────┼────────┐
│          │  Data Source Connector Layer            │        │
│          │                    │                    │        │
│  ┌───────▼─────┐     ┌────────▼────┐      ┌────────▼────┐   │
│  │ Firebase    │     │ HTTP         │      │ LocalStorage │   │
│  │ Connectors  │     │ Connectors   │      │ Connectors   │   │
│  └───────┬─────┘     └────────┬────┘      └────────┬────┘   │
└──────────┼─────────────────────┼─────────────────────┼──────┘
           │                     │                     │
           │                     │                     │
┌──────────┼─────────────────────┼─────────────────────┼──────┐
│          │    Data Source Utility Layer              │      │
│          │                     │                     │      │
│  ┌───────▼─────┐     ┌─────────▼───┐      ┌─────────▼───┐   │
│  │ Firebase    │     │ HTTP        │      │ File        │   │
│  │ Utilities   │     │ Utilities   │      │ Utilities   │   │
│  └─────────────┘     └─────────────┘      └─────────────┘   │
└─────────────────────────────────────────────────────────────┘
```

### 1. Repository Layer

This document outlines the architecture of a library divided into three key parts: the repository, data source connector, and data source util. This structure promotes separation of concerns, testability, and maintainability.

## 1. Repository Layer

- **Purpose:** Acts as an intermediary between the application's business logic (e.g., view models, use cases , state management ) and the data layer (data sources). It provides a clean and consistent API for accessing data, regardless of the data source.

- **Responsibilities:**

  - **Data Abstraction:** Hides the complexities of data retrieval and storage.
  - **Data Aggregation:** Can combine data from multiple data sources.
  - **Caching:** May implement caching mechanisms to improve performance.
  - **Error Handling:** Handles data-related errors and provides a consistent way to report them.
  - **Business Logic:** May contain some business logic related to data manipulation.

- **Example:**

  - A `BaseAuthRepo` might provide methods like `getUserById(int id)`, `userLogIn`, `createUserAccount(User user)`, and `updateUserProfile(User user)`.
  - The repository doesn't care if the data comes from a local database, a remote API, or a file. It just provides the data.

- **Benefits:**
  - **Testability:** Easily mock or stub the repository in unit tests.
  - **Maintainability:** Changes to the data layer only require modifications in the repository layer.
  - **Flexibility:** Easily add or remove data sources without affecting the rest of the application.

## 2. Data Source Connector Layer

- **Purpose:** Responsible for interacting with specific data sources (e.g., a database, a REST API, a file). It provides a low-level interface for reading and writing data.

- **Responsibilities:**

  - **Data Source Interaction:** Handles the specific details of communicating with a particular data source.
  - **Data Mapping:** Maps data from the data source to the application's data models.
  - **Error Handling:** Handles errors specific to the data source.

- **Examples:**

  - A `LocalDatabaseConnector` might use SQLite or Room to interact with a local database.
  - A `RemoteApiConnector` might use Retrofit or HTTP to interact with a REST API.
  - A `FirebaseConnections` might use Firebase to interact with a Firebase database.

- **Benefits:**
  - **Encapsulation:** Hides the implementation details of each data source.
  - **Reusability:** Data source connectors can be reused across different parts of the application.
  - **Testability:** Easily mock or stub data source connectors in unit tests.

## 3. Data Source Util Layer

- **Purpose:** Provides utility functions and helper classes used by the data source connectors. It contains common logic shared across multiple data sources.

- **Responsibilities:**

  - **Data Transformation:** Provides functions for transforming data between different formats.
  - **Error Handling:** Provides common error handling logic.
  - **Network Utilities:** Provides utilities for making network requests.
  - **Database Utilities:** Provides utilities for interacting with databases.
  - **File Utilities:** Provides utilities for working with files.

- **Examples:**

  - A `FirebaseAccount` might provide functions for creating, updating, and deleting user accounts in Firebase.
  - A `JodijaHttpClient` might provide functions for making HTTP requests using Dio or http package.

- **Benefits:**
  - **Code Reusability:** Avoids code duplication by providing common logic in a single place.
  - **Maintainability:** Makes it easier to update common logic across multiple data sources.
  - **Consistency:** Ensures that data is handled consistently across the application.

### How These Layers Work Together

1. Business logic (view models, etc.) requests data from the Repository
2. Repository determines which data source(s) to use
3. Repository uses appropriate Data Source Connector to retrieve/store data
4. Data Source Connector uses Utility classes for common tasks
5. Data flows back up through the layers, potentially with transformations at each step

## Application Types

Jodija supports two types of application architectures:

### 1. Multi-Solution Applications

**Description:** Applications with multiple user interfaces across different platforms, all connected to the same backend.

**Architecture:**

```
┌─────────────┐   ┌─────────────┐   ┌─────────────┐
│ Mobile App  │   │  Web App    │   │ Desktop App │
│  (Flutter)  │   │  (Flutter)  │   │  (Flutter)  │
└──────┬──────┘   └──────┬──────┘   └──────┬──────┘
       │                 │                 │
       └─────────┬───────┴─────────┬───────┘
                 │                 │
         ┌───────┴─────────┐       │
         │  Business Logic │       │
         │     Package     │       │
         └───────┬─────────┘       │
                 │                 │
                 ▼                 ▼
         ┌─────────────────────────────┐
         │     Jodija Repository       │
         │    (YAML Configuration)     │
         └─────────────────────────────┘
```

This document outlines two primary types of app solutions, categorized by their architecture and scope.

- Multiple UI platforms (mobile, web, desktop)
- Shared business logic package
- YAML-based configuration

### 2. Single-Solution Applications

**Description:** Applications with a primary UI (typically mobile) and possibly a control panel built with different technology.

**Architecture:**

```
┌─────────────┐   ┌─────────────────────┐
│ Mobile App  │   │    Control Panel    │
│  (Flutter)  │   │ (Web Technologies)  │
└──────┬──────┘   └─────────┬───────────┘
       │                    │
       │           ┌────────┴────────┐
       │           │ Integrated      │
       └───────────► Business Logic  │
                   └────────┬────────┘
                           │
                           ▼
                   ┌───────────────┐
                   │    Jodija     │
                   │   Repository  │
                   └───────────────┘
```

- Single primary UI with optional control panel
- Integrated business logic
- YAML-based configuration

## Getting Started

### Installation

Add Jodija Repository to your `pubspec.yaml`:

```yaml
dependencies:
  jodija_repository:
    git:
      url: https://github.com/zeftawyapps/jodija_data_souce_module.git
```

### Import

```dart
import 'package:jodija_repository/jodija.dart';
```

### Configuration

#### For Multi-Solution Apps

Create a configuration file in your Business Logic package:

```dart
import 'package:jodija_repository/jodija_configration.dart';

class LogicConfiguration extends DataSourceConfigration {
  /**
   * Initializes the service environment configuration.
   *
   * @param envType The environment type ('prod' or 'dev')
   * @param backendState The backend state ('local', 'remote_dev', 'remote_prod')
   * @param appType The application type ('App' or 'Dashboard')
   */
  void setAppConfiguration(
    ServiceEnvType envType,
    SerViceBackendState backendState,
    [SerViceAppType appType = SerViceAppType.App]
  ) {
    this.envType = envType == ServiceEnvType.prod ? EnvType.prod : EnvType.dev;
    this.appType = appType == SerViceAppType.App ? AppType.App : AppType.DashBord;

    switch (backendState) {
      case SerViceBackendState.local:
        this.backendState = BackendState.local;
        break;
      case SerViceBackendState.remote_dev:
        this.backendState = BackendState.remote_dev;
        break;
      case SerViceBackendState.remote_prod:
        this.backendState = BackendState.remote_prod;
        break;
    }
  }

  BackendState isRemote() {
    return backendState;
  }
}

// Configuration enums
enum ServiceEnvType { prod, dev }
enum SerViceAppType { App, Dashboard }
enum SerViceBackendState { local, remote_dev, remote_prod }
```

Then create an app configuration in your UI solution:

```dart
class AppConfiguration extends LogicConfiguration {
  // App-specific configuration options
}
```

#### For Single-Solution Apps

Create a configuration file in your app package:

```dart
class AppConfiguration extends DataSourceConfigration {
  // App-specific configuration options
}
```

## Documentation

For detailed documentation on using Jodija Repository in your projects:

- [Class Documentation](documents/en/the%20head%20lines%20.md)
