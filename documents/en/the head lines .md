to understand this library, you need to know the following classes:
- `Configrastion`: Represents a document.
- `Results`: 
- `Base Model`:
- `abstract class`: 
  * `IBaseDataSourceRepo`:
  * `IBaseSource`:
  * `IBaseStream`:
  * `IBaseDataActionsSource`:
  * `Authintications`:
     * `abstract class`:
       - `IBaseAuthentication`:
       - `IBaseAccountActions`:
       - `IFirebaseAuthentication`:
       - `IHttpAuthentication`:
- `repsatory`:
  * `Authintications`:
    - `BaseAuthRepo`:
    - `BaseProfilRebo`:
  * `DataSourceRepo`
- `source`:
   * `DataSourceFirebaseSource`:
   * `StreamFirebaseDataSource`:
   * `DataSourceDataActionsHttpSources`: 
   * `AuthHttpSource`:
   * `EmailPassowrdAuthSource`:
   * `GoogleAuthSoucre`:
- `utils`:
    * `Firebase`:
      - `FirebaseLoadingData`
      - `FirestoreAndStorageActions`
      - `FireStoreActions`
      - `StorageActions`
    * `Http`: 
      - `JoDijaHttpClient`
      - `HttpLoadingData`