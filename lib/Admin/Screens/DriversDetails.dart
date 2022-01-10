import 'package:flutter/material.dart';
import 'package:gasna_driver/Admin/Model/AmountData.dart';
import 'package:gasna_driver/brand_colors.dart';

class DriversDetails extends StatelessWidget {
  final AdminDriverData driverDetails;
  const DriversDetails({Key key, this.driverDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'التفاصيل',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          CircleAvatar(
            backgroundColor: BrandColors.colorAccent,
            radius: 45,
            child: Icon(
              Icons.person,
              size: 45,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Center(
            child: Text(
              driverDetails.fullName,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            
          )
        ],
      ),
    );
  }
}
