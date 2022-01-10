import 'package:flutter/material.dart';
import 'package:gasna_driver/Admin/Model/AmountData.dart';
import 'package:gasna_driver/Admin/Screens/DriversDetails.dart';

class AdminReportPage extends StatefulWidget {
  static const String id = 'report';
  final List<AdminDriverData> driversDataInfo;
  AdminReportPage({this.driversDataInfo});
  @override
  _AdminReportPageState createState() => _AdminReportPageState();
}

class _AdminReportPageState extends State<AdminReportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'تقارير',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DataTable(
              columns: [
                DataColumn(label: Flexible(child: Text('الاسم'))),
                DataColumn(label: Flexible(child: Text('مكان التوزيع'))),
                DataColumn(label: Flexible(child: Text('المحافظة'))),
              ],
              rows: widget.driversDataInfo
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(Text(e.fullName.toString()), onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DriversDetails(
                                        driverDetails: e
                                      )));
                        }),
                        DataCell(Text(e.place.toString())),
                        DataCell(
                          Text(e.governorate.toString()),
                        ),
                      ],
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
