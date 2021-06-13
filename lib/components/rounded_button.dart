import 'package:flutter/material.dart';

@immutable
class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key? key,
    required this.color,
    required this.label,
    required this.onPressed,
    this.disabled = false,
  }) : super(key: key);

  final Color color;
  final String label;
  final Function onPressed;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: disabled ? null : onPressed as void Function()?,
          minWidth: 200.0,
          height: 42.0,
          disabledColor: Colors.black54,
          disabledTextColor: Colors.black87,
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
