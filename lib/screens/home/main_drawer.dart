// main_drawer.dart

import 'package:flutter/material.dart';
import 'package:plant_app/constants.dart';
import 'package:plant_app/services/database.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: darkGreenColor,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Settings',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: size.height * 0.8,
            child: ListView(
              padding: EdgeInsets.all(26.0),
              children: <Widget>[
                Text(
                  'My plants: ${DatabaseHelper.instance.getCount()} ',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever),
                    label: Text('Delete me')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
