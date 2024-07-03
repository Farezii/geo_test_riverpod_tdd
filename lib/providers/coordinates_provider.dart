import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/database.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';

// TODO: create database with tables for run data and coordinates

class CoordinatesNotifier extends StateNotifier<List<Coordinates>> {
  CoordinatesNotifier() : super(const []);

  // Loads coordinates for a specified run given it's unique ID
  Future<void> loadRunCoordinates(String runId) async {
    final db = await getDatabase();

    final runData = await db.query(
      'runData',
      where: 'id = ?',
      whereArgs: [runId],
    );
    final runDataList = runData
        .map(
          (row) => RunData(
            id: row['id'] as String,
            email: row['email'] as String,
          ),
        )
        .toList();

    final coordinatesData = await db.query(
      'coordinates',
      where: 'runId = ?',
      whereArgs: [runId],
    );
    final coordinatesList = coordinatesData
        .map(
          (row) => Coordinates(
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            runData: RunData(
              email: runDataList.first.email,
              id: row['runId'] as String,
            ),
          ),
        )
        .toList();

    state = coordinatesList;
  }

  void addCoordinates(
      double latitude, double longitude, RunData runData) async {
    final newId = newUuidV4(state);

    final newCoordinateEntry = Coordinates(
      latitude: latitude,
      longitude: longitude,
      runData: runData,
      id: newId,
    );

    final db = await getDatabase();
    await db.insert('coordinates', {
      'latitude': latitude,
      'longitude': longitude,
      'id': newId,
      'runId': runData.id,
    });

    state = [...state, newCoordinateEntry];
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
