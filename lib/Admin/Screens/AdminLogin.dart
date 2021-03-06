import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasna_driver/Admin/Screens/AdminMainPage.dart';
import 'package:gasna_driver/Admin/Screens/AdminRegistration.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/widgets/GradientButton.dart';
import 'package:gasna_driver/widgets/ProgressDialog.dart';

class AdminLoginPage extends StatefulWidget {
  static const String id = 'adminlogin';

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    // ignore: deprecated_member_use
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );

    final User user = (await _auth
            .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      //check error and display message
      Navigator.pop(context);
      PlatformException thisEx = ex;
      showSnackBar(thisEx.message);
    }))
        .user;

    if (user != null) {
      // verify login
      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('admin/${user.uid}');
      userRef.once().then((DataSnapshot snapshot) {
        if (snapshot.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, AdminMainPage.id, (route) => false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Image(
                  alignment: Alignment.center,
                  height: 150.0,
                  width: 150.0,
                  image: AssetImage('images/gasna.png'),
                ),
                Text(
                  '??????????',
                  style: TextStyle(
                      fontSize: 50,
                      color: BrandColors.colorAccent),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                            labelText: '??????????????',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            labelText: '?????? ??????????',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 10.0)),
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GradientButton(
                        title: '????????',
                        onPressed: () async {
                          //check network availability

                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No internet connectivity');
                            return;
                          }

                          if (!emailController.text.contains('@')) {
                            showSnackBar('Please enter a valid email address');
                            return;
                          }

                          if (passwordController.text.length < 8) {
                            showSnackBar('Please enter a valid password');
                            return;
                          }

                          login();
                        },
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    /*Navigator.pushNamedAndRemoveUntil(
                        context, RegistrationPage.id, (route) => false);*/
                  },
                  child: Text(
                    '???????? ?????????? ??????????',
                    style: TextStyle(color: Colors.black, ),
                    
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AdminRegistrationPage.id, (route) => false);
                  },
                  child: Text(
                    '???? ?????????? ?????????? ?????????? ???????? ????????',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
