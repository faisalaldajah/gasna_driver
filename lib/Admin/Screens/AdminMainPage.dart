import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gasna_driver/Admin/Model/AmountData.dart';
import 'package:gasna_driver/Admin/Model/UserData.dart';
import 'package:gasna_driver/Admin/Screens/AdminPakages.dart';
import 'package:gasna_driver/Admin/Screens/ReportPage.dart';
import 'package:gasna_driver/Admin/Screens/registration.dart';
import 'package:gasna_driver/brand_colors.dart';

class AdminMainPage extends StatefulWidget {
  static const String id = 'adminmainpage';

  @override
  _AdminMainPageState createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  List<AdminDriverData> driverdata = [];
  List<AdminUserData> userData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.colorBackground,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: BrandColors.colorBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
          ),
          Container(
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: BrandColors.colorAccent,
                borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AdminRegistrationPage.id);
                },
                child: Text(
                  'إضافة سائق',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: BrandColors.colorAccent,
                borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminReportPage(
                                driverData: driverdata,
                                userData: userData,
                              )));
                },
                child: Text(
                  'التقارير',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            width: 300,
            height: 160,
            decoration: BoxDecoration(
                color: BrandColors.colorAccent,
                borderRadius: BorderRadius.circular(25)),
            child: Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminPakages(driverdata)));
                },
                child: Text(
                  'الحزم',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getData() {
    DatabaseReference driverRef =
        FirebaseDatabase.instance.reference().child('drivers');
    DatabaseReference userRef =
        FirebaseDatabase.instance.reference().child('users');
    var keys;
    AdminDriverData dirver;
    AdminUserData user;
    driverRef.once().then((DataSnapshot snapshot) {
      keys = snapshot.value.keys;
      for (var key in keys) {
        dirver = AdminDriverData(
          amount: snapshot.value[key]['amount']['amount'],
          status: snapshot.value[key]['amount']['status'],
          transNumber: snapshot.value[key]['amount']['transNumber'],
          name: snapshot.value[key]['fullname'],
          number: snapshot.value[key]['phone'],
          storeKey: key,
        );

        driverdata.add(dirver);
      }
    });
    userRef.once().then((DataSnapshot snapshot) {
      keys = snapshot.value.keys;
      for (var key in keys) {
        user = AdminUserData(
          name: snapshot.value[key]['fullname'],
          phone: snapshot.value[key]['phone'],
          storeKey: key,
        );
        userData.add(user);
      }
    });
  }
}
