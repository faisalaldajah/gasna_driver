import 'package:flutter/material.dart';

class TaxiButton extends StatelessWidget {
  final String title;
  final Color color;
  final Function onPressed;

  TaxiButton({this.title, this.onPressed, this.color});

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: color,
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
