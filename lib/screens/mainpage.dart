import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gasna_driver/datamodels/PromoCode.dart';
import 'package:gasna_driver/tabs/earningstab.dart';
import 'package:gasna_driver/tabs/hometab.dart';
import 'package:gasna_driver/tabs/profiletab.dart';
import 'package:gasna_driver/tabs/ratingstab.dart';
import '../brand_colors.dart';

class MainPage extends StatefulWidget {
  static const String id = 'mainpage';
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  int selecetdIndex = 0;
  List<PromoCode> promoCode = [];
  void onItemClicked(int index) {
    setState(() {
      selecetdIndex = index;
      tabController.index = selecetdIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void getPromoCode() {
    DatabaseReference promoCodeRef =
        FirebaseDatabase.instance.reference().child('promo_code');
    PromoCode promo;
    var promoKeys;
    var promoValue;
    promoCodeRef.once().then((DataSnapshot snapshot) {
      var keys = snapshot.value.keys;
      for (var key in keys) {
        promoKeys = key;
        promoValue = snapshot.value[key];
        promo = PromoCode(
          key: promoKeys,
          value: promoValue,
        );
        promoCode.add(promo);
      }
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: <Widget>[
          HomeTab(),
          EarningsTab(),
          RatingsTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'الارباح',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'التقييم',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'الحساب',
          ),
        ],
        currentIndex: selecetdIndex,
        unselectedItemColor: BrandColors.colorIcon,
        selectedItemColor: BrandColors.colorAccent1,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        onTap: onItemClicked,
      ),
    );
  }
}
