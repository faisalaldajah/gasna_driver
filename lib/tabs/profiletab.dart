// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/dataprovider.dart';
import 'package:gasna_driver/globalvariabels.dart';
import 'package:gasna_driver/screens/AddAmount.dart';
import 'package:gasna_driver/widgets/BrandDivier.dart';
import 'package:gasna_driver/widgets/GradientButton.dart';
import 'package:gasna_driver/widgets/HistoryTile.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(color: BrandColors.colorAccent1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${currentDriverInfo.currentAmount}JD',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'الرصيد الحالي',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            (currentDriverInfo == 'true')
                ? Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle,
                          size: 100,
                          color: BrandColors.colorAccent1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${currentDriverInfo.fullName}',
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${currentDriverInfo.governorate}',
                          style: TextStyle(fontSize: 23, color: Colors.black),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          '${currentDriverInfo.place}',
                          style: TextStyle(fontSize: 23, color: Colors.black),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        GradientButton(
                          title: 'إضافة رصيد',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAmount(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  )
                : Container(
                    child: Column(
                      children: [
                        Container(
                          color: BrandColors.colorBackground,
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 70),
                            child: Column(
                              children: [
                                Text(
                                  'مجموع الارباح اليوم',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 28),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '\$${Provider.of<AppData>(context).earnings}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 40,
                                      fontFamily: 'Brand-Bold'),
                                ),
                                Container(
                                  child: ListView.separated(
                                    padding: EdgeInsets.all(0),
                                    itemBuilder: (context, index) {
                                      return HistoryTile(
                                        history: Provider.of<AppData>(context)
                                            .tripHistory[index],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            BrandDivider(),
                                    itemCount: Provider.of<AppData>(context)
                                        .tripHistory
                                        .length,
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
