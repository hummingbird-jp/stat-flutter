import 'package:flutter/material.dart';

@immutable
class RoundedOutlineButton extends StatelessWidget {
  final Color color;
  final String label;
  final Function onPressed;

  const RoundedOutlineButton({
    required this.color,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: Colors.transparent,
        shape: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: color),
        ),
        child: MaterialButton(
          onPressed: onPressed as void Function()?,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
