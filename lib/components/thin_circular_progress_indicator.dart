import 'package:flutter/material.dart';

class ThinCircularProgressIndicator extends StatelessWidget {
  const ThinCircularProgressIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: Color(0xFFEB1555),
      strokeWidth: 2.0,
    );
  }
}
