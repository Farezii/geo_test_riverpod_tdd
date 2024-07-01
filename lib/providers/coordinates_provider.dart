import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

// TODO: create database with tables for run data and coordinates

class CoordinatesNotifier extends StateNotifier<List<Coordinates>> {
  CoordinatesNotifier() : super(const []);

  void loadCoordinates() {
    // TODO: After applying DB, load
    // Temp state load, same as reset
    state = [];
  }

  void addCoordinates(Coordinates coordinates) {
    state = [...state, coordinates];
    // TODO: check if new coordinates are new limits to overall area
  }

  void resetCoordinates() {
    // TODO: After DB is applied, use this function to reset it after starting new run
    final List<Coordinates> coordinatesList = [];
    state = coordinatesList;
  }

  Map<String, dynamic> findDelimitations(List<Coordinates> listCoordinates) {
    Map<String, dynamic> areaDelimitation = {
      'topLeftCorner': null,
      'topRightCorner': null,
      'bottomLeftCorner': null,
      'bottomRightCorner': null,
    };

    if (listCoordinates.isEmpty || listCoordinates.length < 3) {
      return areaDelimitation;
    }

    areaDelimitation['topLeftCorner'] = listCoordinates.first;
    areaDelimitation['topRightCorner'] = listCoordinates.first;
    areaDelimitation['bottomLeftCorner'] =
        listCoordinates.elementAt(1); // second element of the guaranteed 3
    areaDelimitation['bottomRightCorner'] = listCoordinates.last;

    for (Coordinates coordinate in listCoordinates) {
      if (coordinate.latitude < areaDelimitation['topLeftCorner'].latitude &&
          coordinate.longitude > areaDelimitation['topLeftCorner'].longitude) {
        areaDelimitation['topLeftCorner'] = coordinate;
      }

      if (coordinate.latitude > areaDelimitation['topRightCorner'].latitude &&
          coordinate.longitude > areaDelimitation['topRightCorner'].longitude) {
        areaDelimitation['topRightCorner'] = coordinate;
      }

      if (coordinate.latitude < areaDelimitation['bottomLeftCorner'].latitude &&
          coordinate.longitude >
              areaDelimitation['bottomLeftCorner'].longitude) {
        areaDelimitation['bottomLeftCorner'] = coordinate;
      }

      if (coordinate.latitude >
              areaDelimitation['bottomRightCorner'].latitude &&
          coordinate.longitude >
              areaDelimitation['bottomRightCorner'].longitude) {
        areaDelimitation['bottomRightCorner'] = coordinate;
      }
    }

    return areaDelimitation;
  }
}

final coordinatesProvider =
    StateNotifierProvider<CoordinatesNotifier, List<Coordinates>>(
  (ref) => CoordinatesNotifier(),
);
