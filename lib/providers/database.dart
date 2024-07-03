import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

import 'package:path/path.dart' as path;

Future<Database> getDatabase() async {
  final dbPath = await sql.getDatabasesPath();

  String runDataTableCreate =
      'CREATE TABLE runData(id TEXT PRIMARY KEY, email TEXT NOT NULL);';

  String coordTableCreate =
      'CREATE TABLE coordinates(id TEXT PRIMARY KEY, latitude DOUBLE NOT NULL, longitude DOUBLE NOT NULL, FOREIGN KEY (runId) REFERENCES runData (id) ON DELETE CASCADE);';

  // sql.deleteDatabase(path.join(dbPath, 'images.db'));

  final db = await sql.openDatabase(
    path.join(dbPath, 'coordinates_geolocator.db'),
    onCreate: (db, version) {
      db.execute(
        runDataTableCreate,
      );
      db.execute(
        coordTableCreate,
      );
    },
    version: 1,
  );

  // for debug purposes, dropping the table
  // bool dropTable = true;
  // if(dropTable){
  //   await db.delete('user_images');
  // }

  return db;
}
