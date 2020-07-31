// home_screen.dart

import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/models/plant.dart';
import 'package:plant_app/screens/add_plant/add_plant_screen.dart';
import 'package:plant_app/screens/plant_detail/plant_detail_screen.dart';
import 'package:plant_app/services/database.dart';
import 'main_drawer.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key key,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // _deletePlant(Plant plant) {
  //   DatabaseHelper.instance.deletePlant(plant.id);
  //   DatabaseHelper.instance.getPlants();
  //   Navigator.of(context).pop();
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: darkGreenColor,
        title: Text(
          'My plants',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder<List<Plant>>(
                future: DatabaseHelper.instance.getPlants(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData && snapshot.data.isEmpty) {
                    return Center(
                      child: Text(
                        'No data',
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Not watered yet...',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: darkGreenColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (!snapshot.data[index].isWatered) {
                              return ListTile(
                                title: Text(
                                  snapshot.data[index].plantName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: darkGreenColor,
                                  ),
                                ),
                                subtitle: Text(
                                  '${snapshot.data[index].plantType}, ${snapshot.data[index].wateringFrequency}x a week',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () => _navigateToDetail(
                                    context, snapshot.data[index]),
                                trailing: Switch(
                                  activeColor: darkGreenColor,
                                  value: snapshot.data[index].isWatered,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      snapshot.data[index].isWatered = newValue;
                                      DatabaseHelper.instance
                                          .updatePlant(snapshot.data[index]);
                                    });
                                  },
                                ),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print('SNAPSHOT ERROR: ${snapshot.error}');
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Error',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Snapshot error: ${snapshot.error}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
              FutureBuilder<List<Plant>>(
                future: DatabaseHelper.instance.getPlants(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasData && snapshot.data.isEmpty) {
                    return Center(
                      child: Text('No data'),
                    );
                  } else if (snapshot.hasData) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Already watered plants',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: lightGreenColor,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            if (snapshot.data[index].isWatered) {
                              return ListTile(
                                title: Text(
                                  snapshot.data[index].plantName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: darkGreenColor,
                                  ),
                                ),
                                subtitle: Text(
                                  '${snapshot.data[index].plantType}, ${snapshot.data[index].wateringFrequency}x a week',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                onTap: () => _navigateToDetail(
                                    context, snapshot.data[index]),
                                trailing: Switch(
                                  activeColor: darkGreenColor,
                                  value: snapshot.data[index].isWatered,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      snapshot.data[index].isWatered = newValue;
                                      DatabaseHelper.instance
                                          .updatePlant(snapshot.data[index]);
                                    });
                                  },
                                ),
                              );
                            } else if (snapshot.data[index].isWatered &&
                                snapshot.data.isEmpty) {
                              return Center(
                                child: Text('No plants watered yet.'),
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    print('SNAPSHOT ERROR: ${snapshot.error}');
                    return Container(
                      padding: EdgeInsets.all(20),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Error',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Text(
                            'Snapshot error: ${snapshot.error}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 10, bottom: 20),
        child: new FloatingActionButton(
          elevation: 10,
          backgroundColor: lightGreenColor,
          onPressed: () {
            print('addPlantButton(): --> User is creating a new plant.');
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddPlantScreen(),
              ),
            );
          },
          tooltip: 'Add plant',
          child: new Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

_navigateToDetail(BuildContext context, Plant plant) async {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PlantDetailScreen(plant: plant)),
  );
}
