import 'dart:convert';

Plant clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Plant.fromMap(jsonData);
}

String clientToJson(Plant data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Plant {
  String plantName;
  String plantType;
  int wateringFrequency;

  Plant({this.plantName, this.plantType, this.wateringFrequency});

  factory Plant.fromMap(Map<String, dynamic> json) => new Plant(
        plantName: json["plant_name"],
        plantType: json["plant_type"],
        wateringFrequency: json["watering_frequency"],
      );

  Map<String, dynamic> toMap() => {
        "plant_name": plantName,
        "plant_type": plantType,
        "watering_frequency": wateringFrequency,
      };
}
