## What is the Jodija data source

It manages the data flow that we receive or send to servers via APIs or any server platform like Firebase. It reshapes the data to align with business logic for display to the user if the data is coming from the server, or formats it as JSON when sending it to the servers.

## how Jodija data source works ?:

this library devides to three parts :

# Library Architecture: Repository, Data Source Connector, and Data Source Util

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
  - A `JoDijaHttpClient` might provide functions for making HTTP requests using Dio or http package.

- **Benefits:**
  - **Code Reusability:** Avoids code duplication by providing common logic in a single place.
  - **Maintainability:** Makes it easier to update common logic across multiple data sources.
  - **Consistency:** Ensures that data is handled consistently across the application.

## How These Layers Work Together

1.  **Business Logic (e.g., View Model) requests data from the Repository.**
2.  **The Repository determines which data source(s) to use.**
3.  **The Repository uses the appropriate Data Source Connector to retrieve or store data.**
4.  **The Data Source Connector uses Data Source Util classes for common tasks.**
5.  **The Data Source Connector returns the data to the Repository.**
6.  **The Repository may transform or aggregate the data before returning it to the Business Logic.**

## Benefits of This Architecture

- **Separation of Concerns:** Each layer has a specific responsibility, making the code easier to understand, maintain, and test.
- **Testability:** Each layer can be tested independently using mocks or stubs.
- **Maintainability:** Changes to one layer have minimal impact on other layers.
- **Flexibility:** You can easily add or remove data sources without affecting the rest of the application.
- **Reusability:** Data source connectors and util classes can be reused across different parts of the application.

This layered architecture is a powerful way to manage data in complex applications. By separating concerns and providing clear interfaces between layers, you can create a more robust, maintainable, and testable application.

## Types of App Solutions

This document outlines two primary types of app solutions, categorized by their architecture and scope.

### 1. Multi-Solution Apps

- **Description:** These apps offer multiple user interfaces (solutions) across different platforms, all connected to the same backend. A common example is a mobile app, a web app, and a desktop app that share data and business logic.
- **Technology Example:** A mobile app and a control panel built using Flutter, connected to the same server and database.
- **Key Characteristics:**
  - **Multiple Frontends:** Provides user interfaces for various platforms (e.g., mobile, web, desktop).
  - **Shared Backend:** All frontends connect to a single server and database.
  - **Data Source Dependency:** The data source (e.g., Jodija) relies on a YAML configuration file.
- **Architecture:**

  - Mobile App (Flutter) called Ui selution
  - Web App (Flutter) called Ui selution
  - Desktop App (Flutter) called Ui selution
  - Middle Package (Business Logic) called Business Logic

  - Jodija Data Source (YAML-based)

### 2. Single-Solution Apps

- **Description:** These apps provide a single user interface, typically a mobile app, with a control panel built using a different technology.
- **Technology Example:** A mobile app with a control panel built using React.js, Angular.js, or another web technology.
- **Key Characteristics:**
  - **Single Frontend:** Primarily focuses on a single user interface (e.g., a mobile app).
  - **Separate Control Panel:** A control panel is built using a different technology.
  - **Integrated Logic:** All packages and business logic are contained within the same package.
  - **Data Source Dependency:** The data source (e.g., Jodija) relies on a YAML configuration file.
- **Architecture:**
  - Mobile App
  - Control Panel (React.js, Angular.js, etc.)
  - Integrated Packages and Business Logic
  - Jodija Data Source (YAML-based) on _Integrated Packages_

## Usage

before you start using the library you need to determine the type of your app solution and the architecture you will use, then you can start using the library by following the steps below:

1. install the library by adding the following line to your pubspec.yaml file:

```yaml
dependencies:
  JoDija_reposatory:
  git:
  url: https://github.com/zeftawyapps/jodija_data_souce_module.git
```

> **Note:** If you are building a multi-solution app, you need to depend the JoDija data source on a YAML file located within the Business Logic package, and the Business Logic package on a YAML file located within the App. 2. import the library in your dart file:

```dart
import 'package:jodija_data_source/jodija_data_source.dart';
```

3.  Configration the data soruce by following the below:

- if you are building a multi-solution app, then the configuration file should be located within the Business Logic package.
  so you will add this code to the configuration file:

```dart
import 'package:JoDija_reposatory/jodija_configration.dart';

class LogicConfigration extends DataSourceConfigration {
  /**
   * Constructor for initializing the service environment.
   *
   * @param senvType The environment type (e.g., `prod`, `dev`).
   * @param sBackendState The backend state (e.g., `local`, `remote_dev`, `remote_prod`).
   *                      This parameter determines whether the backend is local or remote.
   * @param app The application type (e.g., `App`, `Dashboard`).
   *            This parameter specifies the UI solution, such as a user website or an admin control panel, and is used to configure routes.
   */
  setAppConfigration(ServiceEnvType senvType
     ,   SerViceBackendState sBackendState) {
    envType = senvType == ServiceEnvType.prod ? EnvType.prod : EnvType.dev;
    appType = app == SerViceAppType.App ? AppType.App : AppType.DashBord;
    switch (sBackendState) {
      case SerViceBackendState.local:
        backendState = BackendState.local;
        break;
      case SerViceBackendState.remote_dev:
        backendState = BackendState.remote_dev;
        break;
      case SerViceBackendState.remote_prod:
        backendState = BackendState.remote_prod;
        break;
    }
  }


  BackendState isRemote() {
    return backendState;
  }
}
// this is the enums that you will use in the configuration file
enum ServiceEnvType { prod, dev }

enum SerViceAppType { App, Dashboard }

enum SerViceBackendState { local, remote_dev, remote_prod }

```

and in the Ui solution you will add this code to the configuration file:

```dart
class AppConfigration  extends LogicConfigration  {
// this is the enums that you will use in the configuration file
  }
```

to Know more about the configurations and use the library you in multi-solution app you can visit the [Multi solution app usage ]()

- if you are building a single-solution app, then the configuration file should be located within the App package.
  so you will add this code to the configuration file:
  ```dart
  class AppConfigration  extends DataSourceConfigration  {
     // this is the enums that you will use in the configuration file
   }
  ```
  to Know more about the configurations and use the library you in single-solution app you can visit the [Single solution app usage ]()
