import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gasna_driver/Admin/Screens/AdminLogin.dart';
import 'package:gasna_driver/Admin/Screens/AdminMainPage.dart';
import 'package:gasna_driver/Admin/Screens/ReportPage.dart';
import 'package:gasna_driver/Admin/Screens/AdminRegistration.dart';
import 'package:gasna_driver/dataprovider.dart';
import 'package:gasna_driver/globalvariabels.dart';
import 'package:gasna_driver/screens/StartPage.dart';
import 'package:gasna_driver/screens/login.dart';
import 'package:gasna_driver/screens/mainpage.dart';
import 'package:gasna_driver/screens/registration.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // ignore: await_only_futures
  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'JF-Flat-regular',
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute:
            (currentFirebaseUser == null) ? LoginPage.id : StartPage.id,
        //(currentFirebaseUser == null) ? LoginPage.id : StartPage.id,
        //(currentFirebaseUser == null) ? AdminLoginPage.id : AdminMainPage.id,
        //RegistrationPage.id,
        routes: {
          MainPage.id: (context) => MainPage(),
          RegistrationPage.id: (context) => RegistrationPage(),
          StartPage.id: (context) => StartPage(),
          LoginPage.id: (context) => LoginPage(),
          AdminMainPage.id: (context) => AdminMainPage(),
          AdminRegistrationPage.id: (context) => AdminRegistrationPage(),
          AdminLoginPage.id: (context) => AdminLoginPage(),
          AdminReportPage.id: (context) => AdminReportPage(),
        },
      ),
    );
  }
}
