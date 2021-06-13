import 'package:flutter/material.dart';

@immutable
class RoundedOutlineButton extends StatelessWidget {
  const RoundedOutlineButton({
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
        color: Colors.transparent,
        shape: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(30.0),
          ),
          borderSide: BorderSide(color: color),
        ),
        child: MaterialButton(
          onPressed: disabled ? null : onPressed as void Function()?,
          disabledColor: Colors.black54,
          disabledTextColor: Colors.black87,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
