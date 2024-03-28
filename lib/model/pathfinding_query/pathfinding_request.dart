import 'package:json_annotation/json_annotation.dart';
import 'package:pf/model/app_point/app_point.dart';

part 'pathfinding_request.g.dart';

@JsonSerializable()
class MapData {
  final String id;
  final List<String> field;
  @JsonKey(name: 'start')
  final AppPoint start;
  @JsonKey(name: 'end')
  final AppPoint end;

  MapData({required this.id, required this.field, required this.start, required this.end});

  int get tasks => field.map<int>((String row) => (row.split('')..removeWhere((e) => e == 'X')).length).reduce((value, element) => value + element);

  int get height => field.length;

  int get width => field.firstOrNull?.length ?? 0;

  factory MapData.fromJson(Map<String, dynamic> json) => _$MapDataFromJson(json);

  Map<String, dynamic> toJson() => _$MapDataToJson(this);
}
