// add_plant_screen.dart

import 'package:flutter/material.dart';
import 'package:plant_app/components/rounded_button.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/home/home_screen.dart';
import 'package:plant_app/services/database.dart';

class AddPlantScreen extends StatefulWidget {
  final Plant plant;
  const AddPlantScreen({Key key, this.plant}) : super(key: key);
  @override
  _AddPlantScreenState createState() => _AddPlantScreenState();
}

class _AddPlantScreenState extends State<AddPlantScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> plantTypes = ['ornamental plant', 'corp', 'tree'];
  final List<int> frequency = [1, 2, 3, 4, 5, 6, 7];

// form values
  String _plantName;
  String _plantType;
  bool _isWatered = false;
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _savePlant(String _plantName, String _plantType, int _wateringFrequency,
        bool _isWatered) async {
      try {
        await DatabaseHelper.instance.insertPlant(
          Plant(
            plantName: _plantName,
            plantType: _plantType,
            wateringFrequency: _wateringFrequency,
            isWatered: _isWatered,
          ),
        );
        DatabaseHelper.instance.getPlants();
        Navigator.pop(context, "Your plant has been saved.");
      } catch (error) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  title: Text(
                    'Failed to add plant!',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkGreenColor,
                        fontSize: 30),
                  ),
                  content: Text("$error"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text(
                        'Close me!',
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ));
        print("Failed to add plant: $error");
      }
    }

    return Scaffold(
      backgroundColor: lightGreenColor,
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        controller: ScrollController(),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: size.height * 0.025,
              ),
              IconButton(
                alignment: Alignment.topLeft,
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
              SizedBox(
                height: size.height * 0.05,
              ),
              Text(
                'Add a new plant',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 45,
                    color: Colors.white),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              TextFormField(
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Plant name cannot be empty.';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Plant name',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
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
                onChanged: (value) => setState(() => _plantName = value),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                  labelText: 'Plant type',
                  labelStyle: Theme.of(context).textTheme.bodyText2,
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
                onChanged: (value) => setState(() => _plantType = value),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Text(
                'Watering frequency',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SliderTheme(
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
                  value: _value,
                  min: 1,
                  max: 7,
                  divisions: 6,
                  label: '${_value.toInt()}x a week',
                  onChanged: (_wateringFrequency) {
                    setState(
                      () {
                        _value = _wateringFrequency;
                      },
                    );
                  },
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Watered?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.48,
                  ),
                  Switch(
                    activeColor: darkGreenColor,
                    value: _isWatered,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isWatered = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Center(
                child: RoundedButton(
                  text: 'Save',
                  press: () {
                    _savePlant(
                        _plantName, _plantType, _value.toInt(), _isWatered);
                    print('savePlant(): --> New plant $_plantName created.');

                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
