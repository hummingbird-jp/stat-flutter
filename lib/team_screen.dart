import 'package:flutter/material.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text(
      //    'Stat! Flutter',
      //    style: TextStyle(
      //      fontSize: 20.0,
      //    ),
      //  ),
      //),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 50.0,
                ),
                Icon(Icons.close),
              ],
            ),
          ),
          SizedBox(
            width: 50.0,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 50.0,
                ),
                Icon(Icons.check_circle_rounded)
              ],
            ),
          ),
          SizedBox(
            width: 50.0,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person,
                  size: 50.0,
                ),
                Icon(Icons.check_circle_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
