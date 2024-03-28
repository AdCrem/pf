// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pathfinding_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapData _$MapDataFromJson(Map<String, dynamic> json) => MapData(
      id: json['id'] as String,
      field: (json['field'] as List<dynamic>).map((e) => e as String).toList(),
      start: AppPoint.fromJson(json['start'] as Map<String, dynamic>),
      end: AppPoint.fromJson(json['end'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MapDataToJson(MapData instance) => <String, dynamic>{
      'id': instance.id,
      'field': instance.field,
      'start': instance.start,
      'end': instance.end,
    };
