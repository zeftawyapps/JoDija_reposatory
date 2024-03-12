class Cell <T>{
  Cell(this.name ) ;
  String name ;
  T? value ;
  Map<String , dynamic >  toMap (){

    return {name : value} ;
  }
}