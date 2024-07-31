import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/database.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';

class RunDataNotifier extends StateNotifier<List<RunData>> {
  RunDataNotifier() : super(const []);
  final String _databaseName = 'runData';

  Future<void> loadRuns() async {
    final db = await getDatabase();

    final runList = await db.query(_databaseName);

    final runDataList = runList
        .map(
          (row) => RunData(
            id: row['id'] as String,
            email: row['email'] as String,
          ),
        )
        .toList();

    state = runDataList;
  }

  Future<void> addRun(String email, String? id) async {
    String newId;
    if (id == null) {
      newId = newUuidV4(state);
    } else {
      newId = id;
    }

    final newRunEntry = RunData(
      email: email,
      id: newId,
    );

    final db = await getDatabase();

    await db.insert(_databaseName, {
      'id': newRunEntry.id,
      'email': newRunEntry.email,
    });

    state = [...state, newRunEntry];
  }

  void removeRun(String runId) async {
    final db = await getDatabase();

    await db.delete(
      _databaseName,
      where: 'id = ?',
      whereArgs: [runId],
    );

    state.removeWhere((runData) => 'id' == runId);
    state = [...state];
  }

  // void printSqlDatabase() async {
  //   log('querying run db');
  //   final db = await getDatabase();

  //   final runData = await db.rawQuery('SELECT COUNT (*) from $_databaseName');
  //   log(runData.toString());
  // }
}

final runDataProvider = StateNotifierProvider<RunDataNotifier, List<RunData>>(
  (ref) => RunDataNotifier(),
);
