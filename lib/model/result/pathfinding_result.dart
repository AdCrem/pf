import 'package:pf/model/path/path.dart';
import 'package:pf/model/pathfinding_query/pathfinding_request.dart';
import 'package:pf/model/result/result_enum.dart';

import '../app_point/app_point.dart';

class PathfindingResult {
  final MapData _mapData;
  final AppPath _appPath;
  late final List<List<DetailedAppPoint>> result;

  PathfindingResult(this._mapData, this._appPath) {
    final res = _mapData.field.map((String row) => row.split('').map((e) => e == 'X' ? ResultTile.blocked : ResultTile.empty).toList()).toList();

    for (var point in _appPath.points) {
      res[point.x][point.y] = ResultTile.path;
    }
    res[_appPath.first.x][_appPath.first.y] = ResultTile.start;
    res[_appPath.last.x][_appPath.last.y] = ResultTile.end;
    result = List.generate(res.length, (index) => []);
    for (int i = 0; i < res.length; i++) {
      for (int j = 0; j < res[0].length; j++) {
        result[i].add(DetailedAppPoint(x: i, y: j, resultTile: res[i][j]));
      }
    }
  }
}
