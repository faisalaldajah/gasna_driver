import 'package:flutter/material.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/screens/mainpage.dart';

class Dialogs extends StatelessWidget {
  final String status;
  Dialogs({this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.only(top: 300, left: 25, right: 25, bottom: 180),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          SizedBox(height: 20),
          Text(
            'انتظر حتى يتم تعبئة الرصيد في حسابك',
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Image.asset(
            'images/taxi.png',
            height: 50,
          ),
          SizedBox(height: 10),
          Container(
            margin: EdgeInsets.all(20),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
                color: BrandColors.colorAccent1,
                borderRadius: BorderRadius.circular(15)),
            child: TextButton(
              child: Text(
                'حسنا',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainPage.id,
                  (route) => false,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
