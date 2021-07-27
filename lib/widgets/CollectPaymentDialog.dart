import 'package:flutter/material.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/helpers/helpermethods.dart';
import 'package:gasna_driver/widgets/BrandDivier.dart';
import 'package:gasna_driver/widgets/TaxiButton.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class CollectPayment extends StatelessWidget {
  final String paymentMethod;
  final double fares;
  final int finishCode;
  CollectPayment({this.paymentMethod, this.fares, this.finishCode});
  var codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(4.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text('المجموع'),
            SizedBox(
              height: 20,
            ),
            BrandDivider(),
            SizedBox(
              height: 16.0,
            ),
            Text(
              'JD$fares',
              style: TextStyle(fontFamily: 'Brand-Bold', fontSize: 50),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'المبلغ أعلاه هو إجمالي الأجرة التي يجب أن يدفعها الزبون ',
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              width: double.infinity,
              height: 50,
              child: TextFormField(
                controller: codeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: 'كود انهاء الرحلة',
                    labelStyle: TextStyle(
                      fontSize: 14.0,
                    ),
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: 230,
              child: TaxiButton(
                title: (paymentMethod == 'cash') ? 'تأكيد' : 'تأكيد',
                color: BrandColors.colorGreen,
                onPressed: () {
                  if (codeController.text == finishCode.toString()) {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    HelperMethods.totalEstimateFares();
                    HelperMethods.enableHomTabLocationUpdates();
                  } else {
                    Toast.show("قمت بأدخال خاطيء", context,
                        duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
                  }
                },
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
