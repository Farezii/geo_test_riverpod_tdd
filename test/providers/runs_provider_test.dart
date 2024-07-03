// run tests
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:geo_test_riverpod/utils/uuid_utils.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';

import 'container_manip.dart'; // For cerating containers for providers

import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  group('Run provider tests', () {
    // helper functions for database creation
    void createTableRunData(Database db) {
      db.execute(
          'CREATE TABLE runDataTest(id TEXT PRIMARY KEY, email TEXT NOT NULL);');
    }

    Future<void> onConfigure(Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    }

    late Database db;
    late ProviderContainer container;

    const String email = 'pepe@popo.com';

    // setup before each test
    setUp(() async {
      // Initialize the mock container
      container = createContainer();
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory
      databaseFactory = databaseFactoryFfi;

      db = await openDatabase(
        inMemoryDatabasePath,
        version: 1,
        onConfigure: onConfigure,
        onCreate: (db, version) async {
          createTableRunData(db);
        },
      );
    });
    // tear down after each test
    tearDown(() async {
      await db.execute('DROP TABLE IF EXISTS runDataTest;');

      await db.close();
    });

    // load empty table into empty state
    test('Load empty runData table and state', () {
      expect(container.read(runDataProvider), isEmpty);
    });

    // add new entry to runData table
    test('Insert into runData table and state', () async {
      var newId = newUuidV4(container.read(runDataProvider));

      final newEntry = RunData(email: email, id: newId);

      container; //TODO: continue buiilding tests. Check discord for how to mock notifierProviders.

      expect(container.read(runDataProvider), hasLength(1));
    });

    // remove entry from runData table
    test('Remove from runData table and state', () {});

    // load currently existing runData table
    test('Load runData table into state', () {});
  });
}
