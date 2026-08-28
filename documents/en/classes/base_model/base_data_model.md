# BaseEntityDataModel Class

`BaseEntityDataModel` (also referenced as `BaseDataModel`) is the root abstract entity class for all domain and data models in the JoDija Repository library. Any model that is stored in Firebase Firestore or transmitted through HTTP endpoints extends this class.

---

## Properties

- `id`: Unique identifier for the entity (`String?`).
- `map`: Optional `Map<String, dynamic>?` holding auxiliary or serialized data.

---

## Constructors

### `BaseEntityDataModel({String? id})`
Constructs a model instance with an optional identifier.

### `BaseEntityDataModel.fromJson(Map<String, dynamic> json, String? id)`
Factory constructor to instantiate the entity from a JSON map.

---

## Methods

### `Map<String, dynamic> toJson()`
Converts the model instance into a JSON-compatible map for Firestore or HTTP request payloads.

---

## Subclasses

- [`UsersBaseModel`](../implementations/UsersRepo.md): Base model for user profiles (`UserModule`, `ShardUserModel`).
- Custom Domain Models (e.g. `ProductModel`, `OrderModel`, `CategoryModel`).