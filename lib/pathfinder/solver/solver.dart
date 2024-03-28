import 'dart:collection';

import 'package:pf/model/app_point/app_point.dart';
import 'package:pf/model/path/path.dart';
import 'package:pf/model/pathfinding_query/pathfinding_request.dart';

abstract class Solver {
  final MapData mapData;

  Solver({required this.mapData});

  AppPath solve();
}
