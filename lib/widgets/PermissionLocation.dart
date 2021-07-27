import 'package:flutter/material.dart';
import 'package:gasna_driver/brand_colors.dart';

class PermissionLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      margin: EdgeInsets.only(top: 300,left: 25,right: 25,bottom: 200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          Text(
            'تحذير',
            style: TextStyle(fontSize: 20, color: Colors.red),
          ),
          Text(
            'الرجاء تفعيل تحديد الموقع',
            style: TextStyle(fontSize: 23),
          ),
          SizedBox(height: 20),
          Image.asset('images/desticon1.png'),
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
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
