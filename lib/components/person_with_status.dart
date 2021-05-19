import 'package:flutter/material.dart';

class PersonWithStatus extends StatelessWidget {
  final IconData person;
  final IconData status;

  PersonWithStatus({@required this.person, @required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            person,
            size: 50.0,
          ),
          Icon(status),
        ],
      ),
    );
  }
}
