import 'package:flutter/material.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/screens/AmountDetail.dart';

class AddAmount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BrandColors.colorAccent1,
        title: Center(
          child: Text('إختر الحزمة التي تريد'),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 30),
                Text(
                  'اختر المبلغ الذي تريد تحويله',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  '5 , 10 , 15 , 20',
                  style: TextStyle(fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'أولا عليك أن تقوم بتحويل المبلغ المراد شحنه الى محفظة زين كاش التي تحمل رقم ',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '0790984208',
                  style: TextStyle(fontSize: 22),
                ),                
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'ثانيا سوف تأتيك رسالة تحتوي على رقم للحوالة',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'إختر الحزمة التي تريدها في الاسفل',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 40),
                PriceBtn(
                  cardPrice: '5',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '5',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '10',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '10',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '15',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '15',
                        ),
                      ),
                    );
                  },
                ),
                PriceBtn(
                  cardPrice: '20',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AmountDetail(
                          amount: '20',
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PriceBtn extends StatelessWidget {
  PriceBtn({this.cardPrice, this.onPressed});
  final String cardPrice;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BrandColors.colorBackground,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            spreadRadius: 0.3,
            color: BrandColors.colorLightGray,
          ),
        ],
      ),
      margin: EdgeInsets.only(bottom: 30),
      width: 190,
      height: 130,
      child: Center(
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            color: BrandColors.colorBackground,
            borderRadius: BorderRadius.circular(90),
            border: Border.all(width: 3, color: BrandColors.colorAccent),
          ),
          child: Center(
            child: TextButton(
              onPressed: onPressed,
              child: Text(
                '$cardPrice JD',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
