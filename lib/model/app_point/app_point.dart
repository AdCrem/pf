import 'package:json_annotation/json_annotation.dart';

import '../result/result_enum.dart';

part 'app_point.g.dart';


@JsonSerializable()
class AppPoint {
  final int x;
  final int y;

  AppPoint({required this.x, required this.y});

  factory AppPoint.fromJson(Map<String, dynamic> json) => _$AppPointFromJson(json);

  Map<String, dynamic> toJson() => _$AppPointToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is AppPoint) {
      return x == other.x && y == other.y;
    } else {
      return false;
    }
  }
}

class DetailedAppPoint extends AppPoint {
  final ResultTile resultTile;

  DetailedAppPoint({
    required super.x,
    required super.y,
    required this.resultTile,
  });
}
