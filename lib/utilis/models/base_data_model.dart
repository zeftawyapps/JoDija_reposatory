/// A base data model class that represents a data entity with an optional ID.
class BaseEntityDataModel {
  /// The unique identifier for the data entity.
  String? id;
  bool? isArchived; 
  DateTime? createdAt; 
  DateTime? updatedAt; 



  /// A map to hold additional data for the model.
  Map<String, dynamic>? map = Map();

  /// Constructs a [BaseEntityDataModel] instance with an optional [id].
  BaseEntityDataModel({String? id , bool? isArchived, DateTime? createdAt, DateTime? updatedAt}) {
    this.id = id;
    this.isArchived = isArchived;
    this.createdAt = createdAt;
    this.updatedAt = updatedAt;
  }

  /// Creates a [BaseEntityDataModel] instance from a JSON map and an optional [id].
  ///
  /// The [json] parameter is a map containing the data to initialize the model.
  /// The [id] parameter is an optional identifier for the model.
  factory BaseEntityDataModel.fromJson(Map<String, dynamic> json, String? id) {
    return BaseEntityDataModel(id: id)..map = json;
  }

  /// Converts the [BaseEntityDataModel] instance to a JSON map.
  ///
  /// Returns a map containing the data of the model.
  Map<String, dynamic> toJson() {
    return {};
  }
}