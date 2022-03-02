import 'package:flutter/material.dart';
import '../brand_colors.dart';

class GradientButton extends StatefulWidget {
  final String title;
  final Function onPressed;

  GradientButton({this.title, this.onPressed});

  @override
  _GradientButtonState createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              BrandColors.colorAccent,
              BrandColors.colorAccent1,
              BrandColors.colorAccent,
            ]),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: BrandColors.colorAccent,
          ),
        ],
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: Text(
          widget.title,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
    );
  }
}
