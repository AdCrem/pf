import 'package:pf/model/path/path.dart';
import 'package:pf/model/pathfinding_query/pathfinding_request.dart';
import 'package:pf/pathfinder/solver/bfs_solver_impl.dart';
import 'package:pf/pathfinder/solver/solver.dart';

import '../../model/app_point/app_point.dart';

class PathFinder {
  List<AppPath> findShortestPaths(List<MapData> queries) {
    return queries.map((query) => findShortestPath(query)).toList();
  }

  AppPath findShortestPath(MapData query) {
    return  BfsSolver(mapData: query).solve();
  }
}
