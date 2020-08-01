import 'package:good_sprout/models/plant.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Plant ("
          "plant_name TEXT,"
          "plant_type TEXT,"
          "watering_frequency INT"
          ")");
    });
  }

  newPlant(Plant newPlant) async {
    final db = await database;
    var raw = await db.rawInsert(
        "INSERT Into Plant (plant_name, plant_type, watering_frequency)"
        " VALUES (?,?,?,?)",
        [newPlant.plantName, newPlant.plantType, newPlant.wateringFrequency]);
    return raw;
  }

  updatePlant(Plant newPlant) async {
    final db = await database;
    var res = await db.update("Plant", newPlant.toMap(),
        where: "plant_name = ?", whereArgs: [newPlant.plantName]);
    return res;
  }

  getPlant(String plantName) async {
    final db = await database;
    var res = await db
        .query("Plant", where: "plant_name = ?", whereArgs: [plantName]);
    return res.isNotEmpty ? Plant.fromMap(res.first) : null;
  }

  Future<List<Plant>> getAllPlants() async {
    final db = await database;
    var res = await db.query("Plant");
    List<Plant> list =
        res.isNotEmpty ? res.map((c) => Plant.fromMap(c)).toList() : [];
    return list;
  }

  deletePlant(String plantName) async {
    final db = await database;
    return db.delete("Plant", where: "plant_name = ?", whereArgs: [plantName]);
  }

  deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Plant");
  }
}
