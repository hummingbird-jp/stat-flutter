import 'package:flutter/material.dart';

@immutable
class PersonWithStatus extends StatelessWidget {
  final NetworkImage userImage;
  final IconData status;

  const PersonWithStatus({
    Key? key,
    required this.userImage,
    required this.status,
  }) : super(key: key);

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
          const SizedBox(
            height: 30.0,
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
