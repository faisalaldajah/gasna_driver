// ignore_for_file: unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gasna_driver/datamodels/RegistrationData.dart';
import 'package:gasna_driver/globalvariabels.dart';
import 'package:gasna_driver/screens/StartPage.dart';
import 'package:gasna_driver/widgets/GradientButton.dart';
import 'package:gasna_driver/widgets/ProgressDialog.dart';

class DistributionPlace extends StatefulWidget {
  final RegistrationData registrationData;
  DistributionPlace({this.registrationData});
  @override
  _DistributionPlaceState createState() => _DistributionPlaceState();
}

class _DistributionPlaceState extends State<DistributionPlace> {
  bool checkCity = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              alignment: Alignment.center,
              height: 160.0,
              width: 160.0,
              image: AssetImage('images/gasna.png'),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.check_circle_outline_outlined,
                  size: 35,
                  color: Colors.green,
                ),
                SizedBox(width: 20),
                Text(
                  'تم تسجيل الحساب بنجاح',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            GradientButton(
              title: 'تم',
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
