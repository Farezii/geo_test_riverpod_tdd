import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class LatestCoordinateMap extends StatelessWidget {
  LatestCoordinateMap({super.key, required this.latestCoordinates});

  Coordinates? latestCoordinates;

  @override
  Widget build(BuildContext context) {
    if (latestCoordinates == null) {
      return const Placeholder();
    } else {
      return FlutterMap(
        options: MapOptions(
          maxZoom: 22,
          initialZoom: 9.2,
          initialCenter: LatLng(
            latestCoordinates!.latitude,
            latestCoordinates!.longitude,
          ),
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            maxNativeZoom: 20,
          ),
          CircleLayer(circles: [
            CircleMarker(
              point: LatLng(
                latestCoordinates!.latitude,
                latestCoordinates!.longitude,
              ),
              radius: 10,
            )
          ])
        ],
      );
    }
  }
}
