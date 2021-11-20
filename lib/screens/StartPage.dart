// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:gasna_driver/globalvariabels.dart';
import 'package:gasna_driver/widgets/ProgressDialog.dart';

class StartPage extends StatefulWidget {
  static const String id = 'startPage';

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    getCurrentDriverInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ProgressDialog(
          status: 'Loading',
        ),
      ),
    );
  }
}
