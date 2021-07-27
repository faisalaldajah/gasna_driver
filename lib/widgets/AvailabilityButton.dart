import 'package:flutter/material.dart';

class AvailabilityButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  AvailabilityButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return TextButton(
      onPressed: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(25),
          color: color,
        ),
        height: 50,
        width: 200,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
