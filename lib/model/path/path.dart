import '../app_point/app_point.dart';

class AppPath {
  List<AppPoint> points;

  AppPath(this.points);

  AppPoint get last => points.last;
  AppPoint get first => points.first;
  List<AppPoint> get body => points.sublist(1,points.length-1);

  @override
  String toString() {
    return points.fold('',(prev,element)=> '$prev${prev.isNotEmpty?'->':''}(${element.x},${element.y})');
  }
}