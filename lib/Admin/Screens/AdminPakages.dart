import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gasna_driver/Admin/Model/AmountData.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/widgets/ProgressDialog.dart';

class AdminPakages extends StatefulWidget {
  final List<AdminDriverData> driverData;
  
  AdminPakages(this.driverData);

  @override
  State<AdminPakages> createState() => _AdminPakagesState();
}

class _AdminPakagesState extends State<AdminPakages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('الحزم'),
        backgroundColor: BrandColors.colorBackground,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: widget.driverData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              '${widget.driverData[index].name}---${widget.driverData[index].number}',
            ),
            subtitle: Text(widget.driverData[index].transNumber),
            isThreeLine: true,
            onTap: () {
              approve(widget.driverData[index].storeKey, context, index);
            },
            trailing: Text('${widget.driverData[index].amount}JD'),
          );
        },
      ),
    );
  }

  Future<void> approve(String key, BuildContext context, int index) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'تمت التعبئة بنجاح',
      ),
    );
    DatabaseReference driverRef = FirebaseDatabase.instance
        .reference()
        .child('drivers/$key/amount/status');

    driverRef.set('approved');
    setState(() {
      widget.driverData.removeAt(index);
    });

    Navigator.pop(context);
  }
}
