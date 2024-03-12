
import 'cell.dart';
import 'modulscreateor.dart';

class RowofCells<T extends Model >{
  List<Cell> cells = [];
  Map<String  , dynamic>  rowMap ={};
  T? modle;
  RowofCells(this.cells) {
    int _ling = cells.length;
    for(int i = 0 ;i<_ling;i++){
      rowMap.addAll(cells[i].toMap());
    }

  }
  RowofCells.model(T model){

  }

  void addMap(Map<String ,dynamic> map ){
    rowMap.addAll(map);
  }
  void addCell(Cell  map ){
    rowMap.addAll(map.toMap());
  }
  RowofCells.manual(this.rowMap);
  dynamic getvalue(Cell keycell){
    return rowMap[keycell.name];
  }
  dynamic getvalueBykeyname(String  keycell){
    return rowMap[keycell ];
  }
}