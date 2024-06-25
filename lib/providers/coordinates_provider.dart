import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

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

  (Coordinates?, Coordinates?) findDelimitations() {
    final listCoordinates = state;
    double startLatitude;
    double endLatitude;
    double startlongitude;
    double endlongitude;
    Coordinates? startCoordinates;
    Coordinates? endCoordinates;

    if (listCoordinates.isNotEmpty) {
      startLatitude = listCoordinates.first.latitude;
      endLatitude = listCoordinates.first.latitude;
      startlongitude = listCoordinates.first.longitude;
      endlongitude = listCoordinates.first.longitude;

      for (Coordinates coordinates in listCoordinates) {
        if(coordinates.latitude < startLatitude) {
          startLatitude = coordinates.latitude;
        }
        if(coordinates.latitude > endLatitude) {
          endLatitude = coordinates.latitude;
        }
        if(coordinates.longitude < startlongitude) {
          startlongitude = coordinates.longitude;
        }
        if(coordinates.longitude > endlongitude) {
          endlongitude = coordinates.longitude;
        }
      }
      startCoordinates = Coordinates(latitude: startLatitude, longitude: startlongitude);
      endCoordinates = Coordinates(latitude: endLatitude, longitude: endlongitude);
    }

    return (startCoordinates, endCoordinates);
  }
}

final coordinatesProvider =
    StateNotifierProvider<CoordinatesNotifier, List<Coordinates>>(
  (ref) => CoordinatesNotifier(),
);
