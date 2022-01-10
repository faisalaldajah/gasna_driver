import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:gasna_driver/screens/mainpage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'brand_colors.dart';
import 'datamodels/driver.dart';

User currentFirebaseUser;

final CameraPosition googlePlex = CameraPosition(
  target: LatLng(31.954066, 35.931066),
  zoom: 14.4746,
);

String mapKey = 'AIzaSyAFb2IQsOOu6tce0TqbnAsQ04slmShpP2w';

StreamSubscription<Position> homeTabPositionStream;

StreamSubscription<Position> ridePositionStream;

final assetsAudioPlayer = AssetsAudioPlayer();

Position currentPosition;

DatabaseReference rideRef;

Driver currentDriverInfo;

bool isAvailable = false;

String availabilityTitle = 'تفعيل';

String newTrip = 'strat';

Color availabilityColor = BrandColors.colorAccent1;

int numberOfGas;

DatabaseReference driversIsAvailableRef = FirebaseDatabase.instance
    .reference()
    .child('drivers/${currentFirebaseUser.uid}/driversIsAvailable');

void getCurrentDriverInfo(context) async {
  // ignore: await_only_futures
  currentFirebaseUser = await FirebaseAuth.instance.currentUser;
  DatabaseReference driverRef = FirebaseDatabase.instance
      .reference()
      .child('drivers/${currentFirebaseUser.uid}');
  driverRef.once().then((DataSnapshot snapshot) {
    if (snapshot.value != null) {
      currentDriverInfo = Driver.fromSnapshot(snapshot);
      Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
    }
  });
}

// ignore: unused_local_variable
DatabaseReference tripRequestRef = FirebaseDatabase.instance
    .reference()
    .child('drivers/${currentFirebaseUser.uid}/newtrip');

// ignore: non_constant_identifier_names
void GoOnline() {
  Geofire.initialize('driversAvailable');
  Geofire.setLocation(currentFirebaseUser.uid, currentPosition.latitude,
      currentPosition.longitude);

  tripRequestRef.set('waiting');

  //tripRequestRef.onValue.listen((event) {});
}

// ignore: non_constant_identifier_names
void GoOffline() {
  Geofire.removeLocation(currentFirebaseUser.uid);
  if (tripRequestRef != null) {
    tripRequestRef.onDisconnect();
  }
  tripRequestRef.remove();
}

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
