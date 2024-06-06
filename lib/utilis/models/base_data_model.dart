class BaseDataModel{

  String? id ;
  // create to json method and factory forJson
  Map<String, dynamic> toJson(){return {} ; }

  BaseDataModel({String ?id } ){
    this.id = id;
  }
  factory BaseDataModel.fromJson(Map<String, dynamic> json , String? id ) {

    return BaseDataModel(id: id )
      .. map = json;

  }
  Map<String, dynamic>?  map = Map();

}