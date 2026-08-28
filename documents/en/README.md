# English Documentation Portal - JoDija Repository

**English** | [النسخة العربية](../ar/README.md)

Welcome to the official **English Documentation Portal** for `JoDija_reposatory`.

---

## 📚 Documentation Index

### 🚀 Architecture & Core Philosophy
- **[Introduction to JoDija Repository](introduction_en.md)**: Architectural breakdown, Single-Solution vs Multi-Solution philosophy.
- **[Matger Integration Guide](integration_matger_guide.md)**: Practical integration manual for `matger front logic` and `matger express`.

---

### ⚙️ Core Configuration & Utilities
- **[DataSourceConfiguration](classes/configration.md)**: Multi-environment routing, Firebase initialization, and Image Base URLs.
- **[HttpHeader](classes/utils/HttpHeader.md)**: JWT token manager and `x-lang` language localization headers.
- **[HttpClient](classes/utils/JodijaHttpClient.md)**: Advanced Dio-based HTTP client (GET, POST, PUT, DELETE, PATCH).
- **[JDRepoConsole](classes/utils/JDRepoConsole.md)**: Colorized console logger, execution timers, and debug context.
- **[HttpErrors](classes/utils/HttpErrors.md)**: Strongly-typed `BaseError` subclasses and network failure hierarchy.
- **[FCMService](classes/utils/FCMService.md)**: Firebase Cloud Messaging notification service.

---

### 📦 Repositories & Connectors
- **[DataSourceRepo](classes/implementations/DataSourceRepo.md)**: High-level CRUD operations repository.
- **[LoadDataRepo](classes/implementations/LoadDataRepo.md)**: High-performance list loading repository.
- **[BaseAuthRepo](classes/implementations/BaseAuthRepo.md)**: Authentication and session management repository.
- **[BaseUsersRepo](classes/implementations/UsersRepo.md)**: User accounts and directory management repository.
- **[BaseProfilRebo](classes/implementations/BaseProfilRebo.md)**: User profile operations repository.
- **[DataSourceFirebaseSource](classes/implementations/DataSourceFirebaseSource.md)**: Firestore and Firebase Storage connector.
- **[DataSourceDataActionsHttpSources](classes/implementations/DataSourceDataActionsHttpSources.md)**: REST API CRUD connector.
- **[StreamFirebaseDataSource](classes/implementations/StreamFirebaseDataSource.md)**: Real-time reactive Firestore stream connector.

---

### 📑 Models & Results
- **[BaseEntityDataModel](classes/base_model/base_data_model.md)**: Foundational entity model interface.
- **[RemoteBaseModel](classes/base_model/remote_base_model.md)**: Base model for server API responses.
- **[Result](classes/results/result.md)**: Generic operation container (`Result<Error, Data>`).
- **[Cell Models](classes/base_model/cell_models.md)**: Tabular data and spreadsheet models.

---

### 🔍 Quick Class Catalog
- **[Complete Class Summary](classes/class_summary.md)**: Detailed breakdown of all interfaces and implementations.
- **[The Headlines](the%20head%20lines%20.md)**: High-level architecture and class relationships.
