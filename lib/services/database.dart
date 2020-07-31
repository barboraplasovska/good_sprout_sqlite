// database.dart

import 'package:path/path.dart';
import 'package:plant_app/models/plant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String TABLE_PLANTS = "plants";
  static const String COLUMN_ID = "id";
  static const String COLUMN_PLANT_NAME = "plant_name";
  static const String COLUMN_PLANT_TYPE = "plant_type";
  static const String COLUMN_WATERING_FREQUENCY = "watering_frequency";
  static const String COLUMN_IS_WATERED = "is_watered";

  //Create a private constructor
  DatabaseHelper._();

  static const databaseName = 'plants_database.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;
  List<Plant> plantList = List<Plant>();

  Future<Database> get database async {
    if (_database == null) {
      print('Creating new database.');
      return await createDatabase();
    }
    print('Returning database.');
    return _database;
  }

  createDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
      print('createDatabase(): --> Creating plan table.');
      await db.execute("CREATE TABLE $TABLE_PLANTS ("
          "$COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
          "$COLUMN_PLANT_NAME TEXT,"
          "$COLUMN_PLANT_TYPE TEXT,"
          "$COLUMN_WATERING_FREQUENCY INTEGER,"
          "$COLUMN_IS_WATERED INTEGER"
          ")");
    });
  }

  insertPlant(Plant plant) async {
    final db = await database;

    print('insertPlant(): --> Plant ${plant.plantName} added.');

    var res = await db.insert(TABLE_PLANTS, plant.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  Future<List<Plant>> getPlants() async {
    final db = await database;

    var plants = await db.query(
      TABLE_PLANTS,
      columns: [
        COLUMN_ID,
        COLUMN_PLANT_NAME,
        COLUMN_PLANT_TYPE,
        COLUMN_WATERING_FREQUENCY,
        COLUMN_IS_WATERED
      ],
      orderBy: COLUMN_IS_WATERED,
    );
    List<Plant> plantList = List<Plant>();

    plants.forEach((currentPlant) {
      Plant plant = Plant.fromMap(currentPlant);

      plantList.add(plant);
    });

    print('Number of plants: ${plantList.length}');
    print('getPlants(): --> Get plants done.');

    return plantList;
  }

  Future<int> updatePlant(Plant plant) async {
    final db = await database;

    print('Plant ${plant.plantName} updated.');

    return await db.update(TABLE_PLANTS, plant.toMap(),
        where: 'id = ?',
        whereArgs: [plant.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> deletePlant(int id) async {
    var db = await database;

    print('deletePlant(): --> Plant deleted.');
    return await db.delete(
      TABLE_PLANTS,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getCount() async {
    var db = await database;

    var plants = await db.query(
      TABLE_PLANTS,
      columns: [
        COLUMN_ID,
        COLUMN_PLANT_NAME,
        COLUMN_PLANT_TYPE,
        COLUMN_WATERING_FREQUENCY,
        COLUMN_IS_WATERED
      ],
      orderBy: COLUMN_IS_WATERED,
    );
    List<Plant> plantList = List<Plant>();

    plants.forEach((currentPlant) {
      Plant plant = Plant.fromMap(currentPlant);

      plantList.add(plant);
    });

    print('${plantList.length}');
    return plantList.length;
  }
}
