class BaseDataModel{
  // create to json method and factory forJson
  Map<String, dynamic> toJson(){return {} ; }

  BaseDataModel( );
  factory BaseDataModel.fromJson(Map<String, dynamic> json  ) {

    return BaseDataModel( )
      .. map = json;

  }
  Map<String, dynamic>?  map = Map();

}