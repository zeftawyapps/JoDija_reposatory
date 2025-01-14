## Configurations Classes

After you create the project, you need to configure the project to
define the base URL and the Firebase configuration that you will use in the project.

## DataSourceConfiguration Class

This class provides functions to help you determine if you should communicate with Firebase or a regular server.

**Methods**

* **FirebaseInit(String path)**
    * Initializes Firebase with configuration from a JSON file.
    * Reads Firebase configuration from the specified JSON file.
    * Selects the appropriate configuration based on the `envType` (production or development).
    * Initializes Firebase with the selected configuration.
    * Throws an exception if initialization fails.

* **FirebaseInitFromDataJson(Map<String, dynamic> path)**
    * Initializes Firebase with configuration from a provided data map.
    * Selects the appropriate configuration based on the `envType` (production or development).
    * Initializes Firebase with the selected configuration.
    * Throws an exception if initialization fails.

* **backendRoutedInit(String path)**
    * Initializes backend routing with the base URL from a JSON file.
    * Reads base URLs from the specified JSON file.
    * Selects the base URL based on the `backendState` (local, remote_dev, or remote_prod).
    * Sets the selected base URL for backend communication.
    * Throws an exception if initialization fails.

* **backendRoutedInitFromJson(Map<String, dynamic> data)**
    * Initializes backend routing with the base URL from a provided data map.
    * Selects the base URL based on the `backendState` (local, remote_dev, or remote_prod).
    * Sets the selected base URL for backend communication.
    * Throws an exception if initialization fails.

### Properties

* **appType:** (getter/setter) Gets or sets the application type.
* **backendState:** (getter/setter) Gets or sets the backend state.
* **envType:** (getter/setter) Gets or sets the environment type.

**Note:**

* Private fields (`_appType`, `_backendState`, `_envType`) are used to encapsulate the internal state of the class.
* Proper exception handling is crucial for robust initialization.
* Consider using a dependency injection framework to manage dependencies and improve testability.