import "cell.dart";

abstract class Model {
  List<Cell>? cells;

  Map<String, dynamic> mymap = <String, dynamic>{};

  Map<String, dynamic> celltoMap(List<Cell> cells) {
    int i, c;
    c = cells.length;
    i = 0;
    do {
      mymap.addAll({cells[i].name: cells[i].value});
      i++;
    } while (i < c);
    return mymap;
  }

  List<Cell>? toCells();
}
