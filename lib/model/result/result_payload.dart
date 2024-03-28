import 'package:pf/model/path/path.dart';

class ResultPayload {
  final String id;
  final AppPath path;

  ResultPayload({required this.id, required this.path});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'result':{
        'steps': path.points.map((e) => e.toJson()).toList(),
        'path': path.toString(),
      }
    };
  }
}
