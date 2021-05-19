import 'package:flutter/material.dart';
import 'package:stat_flutter/components/person_with_status.dart';

class TeamScreen extends StatefulWidget {
  static const String id = 'team_screen';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PersonWithStatus(
            person: Icons.person,
            status: Icons.check,
          ),
          SizedBox(
            width: 50.0,
          ),
          PersonWithStatus(
            person: Icons.person,
            status: Icons.check,
          ),
          SizedBox(
            width: 50.0,
          ),
          PersonWithStatus(
            person: Icons.person,
            status: Icons.close,
          ),
        ],
      ),
    );
  }
}
