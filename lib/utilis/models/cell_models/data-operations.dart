
import 'cell.dart';
 import 'modulscreateor.dart';
import 'row_cells.dart';

class TableOfCells<T extends Model> {
  late    List<Map<String , dynamic >>  mapList ;
  late    List<RowofCells>  listOfRows ;
T? model ;
  TableOfCells(
      this.mapList){

    getDatarow(mapList);
  }

  TableOfCells.RowInstance(
      this.listOfRows) {

  this.mapList =   getListmap(listOfRows);
  } // Model.Cells(this.cells) {rowofCells = RowofCells(cells!);}

  List <RowofCells> getDatarow(List<Map<String , dynamic >> listMaps){
    List <RowofCells> getDatarows=[];
    for(int i = 0; i<listMaps.length;i++){
      RowofCells rr =     RowofCells.manual(listMaps[i]);
      getDatarows.add(rr);
    }
    return getDatarows;
  }

  List<Map<String , dynamic >>   getListmap(List <RowofCells>listMaps){
    List<Map<String , dynamic >>  getDatarows=[];
    for(int i = 0; i<listMaps.length;i++){

      getDatarows.add(listMaps[i].rowMap);
    }
     return getDatarows;
  }



  List<dynamic > unicGrubs(List<Map<String , dynamic >> listMaps ,Cell  key ){

    List<dynamic >? ss=[];
    for(Map<String ,dynamic> m in listMaps){
      ss.add(m[key.name]);
    }


    print(ss);
    var distinctIds = ss.toSet().toList();
    print(distinctIds);
    return distinctIds ;
  }

  void groubbyCount (List<Map<String , dynamic >> listMaps , Cell keycell ){
    List<dynamic>? keylist ;

    listMaps.map((Map<String , dynamic > map){
      keylist!.add(map[keycell.name]);

    } ).toList();

    List<dynamic>? distinctIds = listMaps.toSet().toList();

    int i = 0 ;

  }

  List< Map<dynamic, int >> countBy ( List<Map<String , dynamic >> data , Cell keycell ){
    List < Map<dynamic, int >> newdata =<Map<dynamic, int >>[];

    List<dynamic>d = unicGrubs(data, keycell);
    int i = 0 ;  int c = d.length;
    do{
      Map<dynamic, int > m =Map<dynamic, int>() ;
      int cc =   data.where((e) => e[keycell.name] == d[i]).length;
      m.addAll( {d[i]:cc}) ;
      newdata.add(m);
      i++;
    }while(i<c);
    print(newdata);
    return newdata ;
  }

  List< Map<dynamic, double >> sumBy ( List<Map<String , dynamic >> data , Cell keycell,Cell sumed ){
    List < Map<dynamic, double >> newdata =<Map<dynamic, double >>[];

    List<dynamic>d = unicGrubs(data, keycell);
    int i = 0 ;  int c = d.length;
    do{
      Map<dynamic, double > m =Map<dynamic, double>() ;
      String v = d[i];
      double sum = 0 ;
      for(int i = 0;i<data.length;i++){
        if (data[i][keycell.name]==v){
          sum +=   data[i][sumed.name];}

      }
      m.addAll( {d[i]:sum}) ;
      newdata.add(m);
      i++;
    }while(i<c);
    print(newdata);
    return newdata ;
  }

}