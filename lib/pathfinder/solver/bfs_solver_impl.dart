import 'dart:collection';

import 'package:pf/model/exceptions/solver_exception.dart';
import 'package:pf/pathfinder/solver/solver.dart';

import '../../model/app_point/app_point.dart';
import '../../model/path/path.dart';
import '../../model/pathfinding_query/pathfinding_request.dart';

class BfsSolver extends Solver {
  BfsSolver({required super.mapData, this.progressCallback});

  static const List<int> dx = [-1, -1, -1, 0, 0, 1, 1, 1];
  static const List<int> dy = [-1, 0, 1, -1, 1, -1, 0, 1];

  late List<List<int>> _dp;
  final Function(int)? progressCallback;
  final Queue<AppPoint> _bfsQueue = Queue();

  @override
  AppPath solve() {
    _dp = mapData.field.map((String row) => row.split('').map((e) => e == 'X' ? 0 : 1).toList()).toList();
    _bfs();
    return _reversePass();
  }

  void _bfs() {
    _bfsQueue.add(mapData.start);

    while (_bfsQueue.isNotEmpty) {
      final currentNode = _bfsQueue.removeFirst();
      if (progressCallback != null) {
        progressCallback!(1);
      }
      final adj = _adj(currentNode);
      for (var point in adj) {
        if ((_dp[point.x][point.y] == 1 || (_dp[currentNode.x][currentNode.y] + 1) < _dp[point.x][point.y]) && point != mapData.start) {
          _dp[point.x][point.y] = _dp[currentNode.x][currentNode.y] + 1;
          _bfsQueue.add(point);
        }
      }
    }
  }

  AppPath _reversePass() {
    if (_dp[mapData.end.x][mapData.end.y] == 1 && mapData.end != mapData.start) {
      ///Graph is not connected
      throw const SolverException('End point is not reachable');
    }
    final List<AppPoint> path = [];
    path.add(mapData.end);

    for (int i = 1; i < _dp[mapData.end.x][mapData.end.y]; i++) {
      path.add(_adj(path[i - 1]).firstWhere((element) => _dp[element.x][element.y] < _dp[path[i - 1].x][path[i - 1].y]));
    }

    return AppPath(path.reversed.toList());
  }

  ///Get neighbouring points to point;
  List<AppPoint> _adj(AppPoint point) {
    List<AppPoint> adjacentPoints = [];

    for (int k = 0; k < dx.length; k++) {
      int x = point.x + dx[k];
      int y = point.y + dy[k];

      if (x >= 0 && x < mapData.height && y >= 0 && y < mapData.width && _dp[x][y] != 0) {
        adjacentPoints.add(AppPoint(x: x, y: y));
      }
    }

    return adjacentPoints;
  }
}
