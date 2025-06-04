import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;
import 'package:latlong2/latlong.dart';

Future<List<LatLng>> loadGpxRoute(String assetPath) async {
  final gpxString = await rootBundle.loadString(assetPath);
  final gpxXml = xml.XmlDocument.parse(gpxString);
  final trkpts = gpxXml.findAllElements('trkpt');
  return trkpts.map((pt) {
    final lat = double.parse(pt.getAttribute('lat')!);
    final lon = double.parse(pt.getAttribute('lon')!);
    return LatLng(lat, lon);
  }).toList();
}
