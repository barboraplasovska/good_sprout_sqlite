// plant_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:plant_app/components/rounded_button.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/services/database.dart';

class PlantDetailScreen extends StatefulWidget {
  final Plant plant;

  const PlantDetailScreen({Key key, this.plant}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreatePlantState(plant);
}

enum ScreenType {
  detail,
  edit,
}

class _CreatePlantState extends State<PlantDetailScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final plantNameController = TextEditingController();
  final plantTypeController = TextEditingController();
  final List<String> plantTypes = ['ornamental plant', 'corp', 'tree'];
  final List<int> frequency = [1, 2, 3, 4, 5, 6, 7];

  ScreenType _screenType = ScreenType.detail;

  Plant plant;

  _CreatePlantState(this.plant);

  Future<void> validateAndSubmit() async {
    try {
      DatabaseHelper.instance.updatePlant(plant);
    } catch (e) {
      print('Error: $e');
    }
  }

  void moveToEdit() {
    print('moveToEdit(): --> User wants to edit his plant.');
    setState(() {
      _screenType = ScreenType.edit;
    });
  }

  void moveToDetail() {
    print('moveToDetail(): --> User is done editing his plant.');
    setState(() {
      _screenType = ScreenType.detail;
    });
  }

  @override
  void initState() {
    super.initState();
    if (plant != null) {
      plantNameController.text = plant.plantName;
      plantTypeController.text = plant.plantType;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _deletePlant(Plant plant) {
      DatabaseHelper.instance.deletePlant(plant.id);
      DatabaseHelper.instance.getPlants();
      Navigator.of(context).pop();
      setState(() {});
    }

    buildWater() {
      if (_screenType == ScreenType.detail) {
        return Text(
          '- ${plant.wateringFrequency} times a week',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: darkGreenColor,
          ),
        );
      } else {
        return SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: darkGreenColor,
            inactiveTrackColor: Colors.white,
            trackShape: RoundedRectSliderTrackShape(),
            trackHeight: 3.0,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
            thumbColor: darkGreenColor,
            overlayColor: darkGreenColor.withAlpha(32),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: lightGreenColor,
            inactiveTickMarkColor: lightGreenColor,
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.white,
            valueIndicatorTextStyle: TextStyle(
              color: darkGreenColor,
            ),
          ),
          child: Slider(
            value: plant.wateringFrequency.truncateToDouble(),
            min: 1,
            max: 7,
            divisions: 6,
            label: '${plant.wateringFrequency.toInt()}x a week',
            onChanged: (_wateringFrequency) {
              setState(
                () {
                  plant.wateringFrequency = _wateringFrequency.toInt();
                },
              );
            },
          ),
        );
      }
    }

    buildPlantName() {
      if (_screenType == ScreenType.detail) {
        return Text(
          plant.plantName,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 48,
            color: Colors.white,
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                'Plant name:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: darkGreenColor,
                ),
              ),
            ),
            TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Plant name cannot be empty.';
                } else {
                  return null;
                }
              },
              controller: plantNameController,
              decoration: InputDecoration(
                hintText: 'Plant name',
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 16.5,
                    fontFamily: primaryFont,
                    fontWeight: FontWeight.normal),
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              onChanged: (value) => setState(() => plant.plantName = value),
            ),
          ],
        );
      }
    }

    buildPlantType() {
      if (_screenType == ScreenType.detail) {
        return Text(
          '- ${plant.plantType}',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
            fontSize: 18,
            color: darkGreenColor,
          ),
        );
      } else {
        return DropdownButtonFormField(
          decoration: InputDecoration(
            hintText: plant.plantType,
            hintStyle: TextStyle(
                color: Colors.black,
                fontSize: 16.5,
                fontFamily: primaryFont,
                fontWeight: FontWeight.normal),
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.white)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: darkGreenColor),
            ),
          ),
          items: plantTypes.map((plantType) {
            return DropdownMenuItem(
              value: plantType,
              child: Text('$plantType'),
            );
          }).toList(),
          onChanged: (value) => setState(() => plant.plantType = value),
        );
      }
    }

    buildSubmitButton() {
      if (_screenType == ScreenType.detail) {
        return IconButton(
          icon: Icon(Icons.mode_edit),
          color: darkGreenColor,
          onPressed: () {
            moveToEdit();
          },
        );
      } else {
        return Container();
      }
    }

    buildSaveButton() {
      if (_screenType == ScreenType.edit) {
        return Center(
          child: RoundedButton(
            text: 'Save',
            press: () {
              validateAndSubmit();
              moveToDetail();
            },
          ),
        );
      } else {
        return Container();
      }
    }

    return Scaffold(
      backgroundColor: lightGreenColor,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        bottomOpacity: 0,
        elevation: 0,
        backgroundColor: lightGreenColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            color: darkGreenColor,
            onPressed: () {
              _deletePlant(plant);
              setState(() {});
            },
          ),
          buildSubmitButton(),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            buildPlantName(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Plant type:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: darkGreenColor,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            buildPlantType(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Watering frequency:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: darkGreenColor,
              ),
            ),
            buildWater(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Watered?',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: darkGreenColor,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.4,
                ),
                Switch(
                  activeColor: darkGreenColor,
                  value: plant.isWatered,
                  onChanged: (bool newValue) {
                    setState(() {
                      plant.isWatered = newValue;
                      DatabaseHelper.instance.updatePlant(plant);
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            buildSaveButton(),
          ],
        ),
      ),
    );
  }
}
