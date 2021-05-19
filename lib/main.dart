import 'package:flutter/material.dart';
import 'package:stat_flutter/team_screen.dart';

void main() {
  runApp(Stat());
}

class Stat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.transparent,
      ),
      home: TeamScreen(),
    );
  }
}
