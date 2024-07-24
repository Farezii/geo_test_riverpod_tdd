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
      'latitude': latitude.toDouble(),
      'longitude': longitude.toDouble(),
      'id': newId,
      'runId': runData.id,
    });

    state = [...state, newCoordinateEntry];
  }

  void removeCoordinates(String coordinatesId) async {
    final db = await getDatabase();
    await db.delete(
      'coordinates',
      where: 'id = ?',
      whereArgs: [coordinatesId],
    );

    state.removeWhere((item) => item.id == coordinatesId);
  }

  void resetCoordinates() {
    // TODO: After DB is applied, use this function to reset it after starting new run
    final List<Coordinates> coordinatesList = [];
    state = coordinatesList;
  }
}

final coordinatesProvider =
    StateNotifierProvider<CoordinatesNotifier, List<Coordinates>>(
  (ref) => CoordinatesNotifier(),
);
