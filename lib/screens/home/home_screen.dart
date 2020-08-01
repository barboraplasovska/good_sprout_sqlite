// home_screen.dart

import 'package:flutter/material.dart';
import 'package:good_sprout/constants.dart';
import 'package:good_sprout/models/plant.dart';
import 'package:good_sprout/screens/add_plant/add_plant_screen.dart';
import 'package:good_sprout/services/database.dart';
import 'main_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
    /* this.auth, this.userId, this.onSignedOut */
  }) : super(key: key); //update this to include the uid in the constructor

  /* final BaseAuth auth;
  final VoidCallback onSignedOut;
  final String userId; */

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// data for testing
  List<Plant> testPlants = [
    Plant(plantName: 'Potato', plantType: 'corp', wateringFrequency: 3),
    Plant(plantName: 'Apple tree', plantType: 'tree', wateringFrequency: 1),
    Plant(
        plantName: 'Sunflower', plantType: 'ornamental', wateringFrequency: 7),
  ];

  @override
  Widget build(BuildContext context) {
    // final AuthService _auth = AuthService();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: darkGreenColor,
        title: Text(
          'My plants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: size.width * 0.04),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddPlantScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Plant>>(
        future: DBProvider.db.getAllPlants(),
        builder: (BuildContext context, AsyncSnapshot<List<Plant>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Plant item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  background: Container(color: Colors.red),
                  onDismissed: (direction) {
                    DBProvider.db.deletePlant(item.plantName);
                  },
                  child: ListTile(
                      title: Text(item.plantName),
                      leading: Text(item.plantType)),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
