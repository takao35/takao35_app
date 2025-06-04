import 'package:flutter/material.dart';

class RouteInfo {
  final String path;
  final String name;
  final Color color;

  const RouteInfo(this.path, this.name, this.color);
}

final List<RouteInfo> routeList = [
  RouteInfo('assets/routes/route01.gpx', '1号路', Colors.red),
  RouteInfo('assets/routes/route02.gpx', '2号路', Colors.blue),
  RouteInfo('assets/routes/route03.gpx', '3号路', Colors.green),
  RouteInfo('assets/routes/route04.gpx', '4号路', Colors.orange),
  RouteInfo('assets/routes/route06.gpx', '6号路', Colors.purple),
  RouteInfo('assets/routes/route07.gpx', '稲荷山', Colors.brown),
  RouteInfo('assets/routes/route08.gpx', '裏高尾', Colors.teal),
  RouteInfo('assets/routes/route09.gpx', '蛇滝', Colors.cyan),
  RouteInfo('assets/routes/route10.gpx', '琵琶滝', Colors.indigo),
  RouteInfo('assets/routes/route11.gpx', '高尾山頂ルート', Colors.deepOrange),
];

// lib/config/route_config.dart
final List<String> routeGpxPaths = [
  'assets/routes/route01.gpx',
  'assets/routes/route02.gpx',
  'assets/routes/route03.gpx',
  'assets/routes/route04.gpx',
  'assets/routes/route06.gpx',
  'assets/routes/route07.gpx',
  'assets/routes/route08.gpx',
  'assets/routes/route09.gpx',
  'assets/routes/route10.gpx',
  'assets/routes/route11.gpx',
];
