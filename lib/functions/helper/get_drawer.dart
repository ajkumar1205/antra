import 'package:flutter/material.dart';

import '../../design/color.dart';

Widget getDrawer() {
  return Drawer(
    backgroundColor: Colors.black,
    surfaceTintColor: Colors.black,
    elevation: 20,
    width: 250,
    child: ListView(
      children: [
        DrawerHeader(
          child: CircleAvatar(
            backgroundColor: subColor,
            child: Icon(
              Icons.person,
              size: 80,
              color: Colors.black,
            ),
          ),
        ),
        Card(
          color: subColor,
          child: ListTile(
            title: Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Card(
          color: subColor,
          child: ListTile(
            title: Text(
              "DarkTheme",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Switch(value: true, onChanged: (val) {}),
          ),
        ),
      ],
    ),
  );
}
