import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/widgets/maps/render_map.dart';

class ShowMapCoordinate extends StatelessWidget {
  ShowMapCoordinate({super.key, required this.listCoordinates});

  List<Coordinates> listCoordinates;

  @override
  Widget build(BuildContext context) {
    if (listCoordinates.isEmpty) {
      return const Placeholder();
    } else {
      return LatestCoordinateMap(latestCoordinates: listCoordinates.last,);
    }
  }
}