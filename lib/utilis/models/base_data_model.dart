/// A base data model class that represents a data entity with an optional ID.
class BaseDataModel {
  /// The unique identifier for the data entity.
  String? id;

  /// A map to hold additional data for the model.
  Map<String, dynamic>? map = Map();

  /// Constructs a [BaseDataModel] instance with an optional [id].
  BaseDataModel({String? id}) {
    this.id = id;
  }

  /// Creates a [BaseDataModel] instance from a JSON map and an optional [id].
  ///
  /// The [json] parameter is a map containing the data to initialize the model.
  /// The [id] parameter is an optional identifier for the model.
  factory BaseDataModel.fromJson(Map<String, dynamic> json, String? id) {
    return BaseDataModel(id: id)..map = json;
  }

  /// Converts the [BaseDataModel] instance to a JSON map.
  ///
  /// Returns a map containing the data of the model.
  Map<String, dynamic> toJson() {
    return {};
  }
}