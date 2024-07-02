import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/database.dart';
import 'package:uuid/uuid.dart';

class RunDataNotifier extends StateNotifier<List<RunData>> {
  RunDataNotifier() : super(const []);

  Future<void> loadRuns() async {
    final db = await getDatabase();

    final runList = await db.query('runData');

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

  Future<void> addRun(String email) async {
    const uuid = Uuid();
    String newId;

    // Generate a unique ID
    do {
      newId = uuid.v4();
    } while (state.any((run) => run.id == newId));

    final newRunEntry = RunData(
      email: email,
      id: newId,
    );

    final db = await getDatabase();

    await db.insert('runData', {
      'id': newRunEntry.id,
      'email': newRunEntry.email,
    });

    state = [...state, newRunEntry];
  }

  void removeRun(String runId) async {
    final db = await getDatabase();

    await db.delete(
      'runData',
      where: 'id = ?',
      whereArgs: [runId],
    );

    state.removeWhere((runData) => 'id' == runId);
    // state = [...state];
  }
}

final runDataProvider = StateNotifierProvider<RunDataNotifier, List<RunData>>(
  (ref) => RunDataNotifier(),
);
