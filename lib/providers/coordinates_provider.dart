import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/database.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';

class CoordinatesNotifier extends StateNotifier<List<Coordinates>> {
  CoordinatesNotifier() : super(const []);
  final String _databaseName = 'coordinates';

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
      _databaseName,
      where: 'runId = ?',
      whereArgs: [runId],
    );
    final coordinatesList = coordinatesData
        .map(
          (row) => Coordinates(
            id: row['id'] as String,
            latitude: row['latitude'] as double,
            longitude: row['longitude'] as double,
            runData: RunData(
              email: runDataList.first.email,
              id: row['runId'] as String,
            ),
          ),
        )
        .toList();

    state = [...coordinatesList];
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
    await db.insert(_databaseName, {
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
      _databaseName,
      where: 'id = ?',
      whereArgs: [coordinatesId],
    );

    state.removeWhere((item) => item.id == coordinatesId);
    state = [...state];
  }

  void resetCoordinates() {
    // TODO: After DB is applied, use this function to reset it after starting new run
    final List<Coordinates> coordinatesList = [];
    state = coordinatesList;
  }

  // void printSqlDatabase() async {
  //   log('querying coordinate db');
  //   final db = await getDatabase();

  //   final coordinates = await db.rawQuery('SELECT COUNT (*) from $_databaseName');
  //   log(coordinates.toString());
  // }
}

final coordinatesProvider =
    StateNotifierProvider<CoordinatesNotifier, List<Coordinates>>(
  (ref) => CoordinatesNotifier(),
);
