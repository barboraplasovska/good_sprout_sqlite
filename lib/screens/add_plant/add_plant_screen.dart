import 'package:flutter/material.dart';
import 'package:good_sprout/components/rounded_button.dart';
import 'package:good_sprout/constants.dart';
import 'package:good_sprout/screens/home/home_screen.dart';
import 'dart:async';
import 'package:path/path.dart';

class AddPlantScreen extends StatefulWidget {
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
  int _wateringFrequency;
  double _value = 1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future<void> addPlant() {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                title: Text(
                  'Failed to add plant:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: darkGreenColor,
                      fontSize: 30),
                ),
                content: Text("error"),
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
      print("Failed to add plant: error");
    }

    ;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(20),
            controller: ScrollController(),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  IconButton(
                    iconSize: 30,
                    icon: Icon(Icons.arrow_back),
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
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: darkGreenColor,
                      inactiveTrackColor: Colors.white,
                      trackShape: RoundedRectSliderTrackShape(),
                      trackHeight: 3.0,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12.0),
                      thumbColor: darkGreenColor,
                      overlayColor: darkGreenColor.withAlpha(32),
                      overlayShape:
                          RoundSliderOverlayShape(overlayRadius: 28.0),
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
                  Center(
                    child: RoundedButton(
                      text: 'Save',
                      press: () {
                        addPlant();
                        /* try {
                          await databaseReference
                              .collection("plants")
                              .document(_plantName)
                              .setData({
                            'plant': _plantName,
                            'plant type': _plantType,
                            'watering frequency': _wateringFrequency
                          });

                          DocumentReference ref =
                              await databaseReference.collection("plants").add({
                            'plant': _plantName,
                            'plant type': _plantType,
                            'watering frequency': _wateringFrequency
                          });

                          print(ref.documentID);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ),
                          );
                        } catch (e) {
                          debugPrint(e.toString());
                        } */
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
