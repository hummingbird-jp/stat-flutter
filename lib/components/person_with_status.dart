import 'package:flutter/material.dart';

class PersonWithStatus extends StatelessWidget {
  final NetworkImage userImage;
  final IconData status;

  PersonWithStatus({required this.userImage, required this.status});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: userImage,
            radius: 60.0,
          ),
          Icon(
            status,
            color: status == Icons.check ? Colors.green : Colors.red,
            size: 40.0,
          ),
        ],
      ),
    );
  }
}
