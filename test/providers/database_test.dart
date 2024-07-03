import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future main() async {
  group('Database tests', () {
    late Database db;
    setUp(() async {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;

      String runDataTableCreateTest =
          'CREATE TABLE runDataTest(id TEXT PRIMARY KEY, email TEXT NOT NULL);';

      String coordTableCreateTest =
          'CREATE TABLE coordinatesTest(id TEXT PRIMARY KEY, latitude DOUBLE NOT NULL, longitude DOUBLE NOT NULL, runId TEXT NOT NULL, FOREIGN KEY(runId) REFERENCES runData(id) ON DELETE CASCADE);';

      db = await openDatabase(inMemoryDatabasePath, version: 1,
          onCreate: (db, version) async {
        db.execute(
          runDataTableCreateTest,
        );
        db.execute(
          coordTableCreateTest,
        );
      });
    });

    tearDown(() async {
      await db.execute('DROP TABLE runDataTest;');
      await db.execute('DROP TABLE coordinatesTest;');

      await db.close();
    });

    RunData runData = RunData(
      email: 'teste@teste.teste',
      id: '-124122414',
    );

    List<Coordinates> mockCoordinates = [
      Coordinates(latitude: -50.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: -50.0, longitude: 0, runData: runData),
      Coordinates(latitude: -50.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: 0.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: 0.0, longitude: 0, runData: runData),
      Coordinates(latitude: 0.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: 50.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: 50.0, longitude: 0, runData: runData),
      Coordinates(latitude: 50.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: -25.3, longitude: -50.4, runData: runData),
      Coordinates(latitude: 75.4, longitude: 0, runData: runData),
      Coordinates(latitude: 45.0, longitude: -90.0, runData: runData),
      Coordinates(latitude: -123.5, longitude: 63.8, runData: runData),
    ];

    test('Do tables exist', () async {
      List<Map<String, Object?>> runDataExists = await db.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: ['runDataTest'],
      );
      List<Map<String, Object?>> coordinatesExists = await db.query(
        'sqlite_master',
        where: 'name = ?',
        whereArgs: ['coordinatesTest'],
      );

      expect(runDataExists.first, containsValue('runDataTest'));
      expect(coordinatesExists.first, containsValue('coordinatesTest'));
    });

    // runDataTest tests
    test('runDataTest is empty', () async {
      List<Map<String, Object?>> runDataExists = await db.query('runDataTest');
      expect(runDataExists, hasLength(0));
    });

    test('inserting into runDataTest', () async {
      await db.insert('runDataTest', {
        'email': runData.email,
        'id': runData.id,
      });

      List<Map<String, Object?>> runDataExists = await db.query('runDataTest');
      expect(runDataExists, hasLength(1));
    });

    test('deleting from runDataTest', () async {
      await db.insert('runDataTest', {
        'email': runData.email,
        'id': runData.id,
      });

      await db.delete('runDataTest', where: 'id = ?', whereArgs: [runData.id]);

      List<Map<String, Object?>> runDataExists = await db.query('runDataTest');
      expect(runDataExists, hasLength(0));
    });

    // coordinatesTest tests
    test('coordinatesTest is empty', () async {
      List<Map<String, Object?>> runDataExists =
          await db.query('coordinatesTest');
      expect(runDataExists, hasLength(0));
    });

    test('inserting into coordinatesTest, runData exists', () async {
      await db.insert('runDatatest', {
        'email': runData.email,
        'id': runData.id,
      });

      List<Map<String, Object?>> runDataQuery = await db.query('runDataTest');
      List<bool> runIdExists = [];

      for (Map<String, Object?> item in runDataQuery) {
        runIdExists.add(item.containsValue(runData.id));
      }

      expect(runIdExists, hasLength(1));
      expect(runIdExists, contains(true));

      if (runIdExists.isNotEmpty && runIdExists.contains(true)) {
        await db.insert('coordinatesTest', {
          'id': mockCoordinates.first.id,
          'latitude': mockCoordinates.first.latitude,
          'longitude': mockCoordinates.first.longitude,
          'runId': mockCoordinates.first.runData.id,
        });
      }

      List<Map<String, Object?>> runDataExists =
          await db.query('coordinatesTest');
      expect(runDataExists, hasLength(1));
    });

    test('inserting into coordinatesTest, no runData exists', () async {
      List<Map<String, Object?>> runDataQuery = await db.query('runDataTest');
      List<bool> runIdExists = [];

      for (Map<String, Object?> item in runDataQuery) {
        runIdExists.add(item.containsValue(runData.id));
      }

      expect(runIdExists, hasLength(0));

      if (runIdExists.isNotEmpty && runIdExists.contains(true)) {
        await db.insert('coordinatesTest', {
          'id': mockCoordinates.first.id,
          'latitude': mockCoordinates.first.latitude,
          'longitude': mockCoordinates.first.longitude,
          'runId': mockCoordinates.first.runData.id,
        });
      }

      List<Map<String, Object?>> runDataExists =
          await db.query('coordinatesTest');
      expect(runDataExists, hasLength(0));
    });

    // delete coodinate, mantains rundata table
    test('deleting from coordinatesTest', () async {
      await db.insert('runDatatest', {
        'email': runData.email,
        'id': runData.id,
      });

      List<Map<String, Object?>> runDataQuery = await db.query('runDataTest');
      List<bool> runIdExists = [];

      for (Map<String, Object?> item in runDataQuery) {
        runIdExists.add(item.containsValue(runData.id));
      }

      if (runIdExists.isNotEmpty && runIdExists.contains(true)) {
        await db.insert('coordinatesTest', {
          'id': mockCoordinates.first.id,
          'latitude': mockCoordinates.first.latitude,
          'longitude': mockCoordinates.first.longitude,
          'runId': mockCoordinates.first.runData.id,
        });
      }

      expect(await db.query('runDataTest'), hasLength(1));
      expect(await db.query('coordinatesTest'), hasLength(1));

      await db.delete('coordinatesTest',
          where: 'id = ?', whereArgs: [mockCoordinates.first.id]);

      List<Map<String, Object?>> coordinatesExist =
          await db.query('coordinatesTest');
      expect(coordinatesExist, hasLength(0));

      List<Map<String, Object?>> runDataExists = await db.query('runDatatest');
      expect(runDataExists, hasLength(1));
    });

    // delete from rundatatest, all coordinates are deleted
    test('deleting from runDataTest', () async {
      await db.insert('runDatatest', {
        'email': runData.email,
        'id': runData.id,
      });

      List<Map<String, Object?>> runDataQuery = await db.query('runDataTest');
      List<bool> runIdExists = [];

      for (Map<String, Object?> item in runDataQuery) {
        runIdExists.add(item.containsValue(runData.id));
      }

      if (runIdExists.isNotEmpty && runIdExists.contains(true)) {
        await db.insert('coordinatesTest', {
          'id': mockCoordinates.first.id,
          'latitude': mockCoordinates.first.latitude,
          'longitude': mockCoordinates.first.longitude,
          'runId': mockCoordinates.first.runData.id,
        });
      }

      expect(await db.query('runDataTest'), hasLength(1));
      expect(await db.query('coordinatesTest'), hasLength(1));

      await db.delete('runDataTest', where: 'id = ?', whereArgs: [runData.id]);

      List<Map<String, Object?>> coordinatesExist =
          await db.query('coordinatesTest');
      expect(coordinatesExist, hasLength(0));

      List<Map<String, Object?>> runDataExists = await db.query('runDatatest');
      expect(runDataExists, hasLength(0));
    });
  });
}
