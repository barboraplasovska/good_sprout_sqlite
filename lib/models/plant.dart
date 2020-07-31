// plant.dart

import 'package:plant_app/services/database.dart';

class Plant {
  int id;
  String plantName;
  String plantType;
  int wateringFrequency;
  bool isWatered;

  Plant({
    this.id,
    this.plantName,
    this.plantType,
    this.wateringFrequency,
    this.isWatered,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseHelper.COLUMN_ID: id,
      DatabaseHelper.COLUMN_PLANT_NAME: plantName,
      DatabaseHelper.COLUMN_PLANT_TYPE: plantType,
      DatabaseHelper.COLUMN_WATERING_FREQUENCY: wateringFrequency,
      DatabaseHelper.COLUMN_IS_WATERED: isWatered ? 1 : 0
    };

    if (id != null) {
      map[DatabaseHelper.COLUMN_ID] = id;
    }
    return map;
  }

  Plant.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.COLUMN_ID];
    plantName = map[DatabaseHelper.COLUMN_PLANT_NAME];
    plantType = map[DatabaseHelper.COLUMN_PLANT_TYPE];
    wateringFrequency = map[DatabaseHelper.COLUMN_WATERING_FREQUENCY];
    isWatered = map[DatabaseHelper.COLUMN_IS_WATERED] == 1;
  }
}
