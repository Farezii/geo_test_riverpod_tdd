import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:path/path.dart' as path;

void _createTableCoordinates(Database db) {
  db.execute(
      'CREATE TABLE coordinatesTest(id TEXT PRIMARY KEY, latitude DOUBLE NOT NULL, longitude DOUBLE NOT NULL, runId TEXT NOT NULL, FOREIGN KEY(runId) REFERENCES runData(id) ON DELETE CASCADE);');
}

void _createTableRunData(Database db) {
  db.execute('CREATE TABLE runData(id TEXT PRIMARY KEY, email TEXT NOT NULL);');
}

Future<void> onConfigure(Database db) async {
  await db.execute('PRAGMA foreign_keys = ON');
}

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  // sql.deleteDatabase(path.join(dbPath, 'images.db'));

  final db = await sql.openDatabase(
    path.join(dbPath, 'coordinates_geolocator.db'),
    version: 1,
    onCreate: (db, version) {
      _createTableRunData(db);
      _createTableCoordinates(db);
    },
    onDowngrade: onDatabaseDowngradeDelete,
    onConfigure: onConfigure,
  );

  return db;
}
