import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:gasna_driver/brand_colors.dart';
import 'package:gasna_driver/widgets/AvailabilityButton.dart';
import 'package:gasna_driver/widgets/ConfirmSheet.dart';
import 'package:gasna_driver/widgets/PermissionLocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../globalvariabels.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  var geoLocator = Geolocator();
  var locationOptions = LocationOptions(
      accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 4);

  void getCurrentPosition() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    currentPosition = position;
    LatLng pos = LatLng(position.latitude, position.longitude);
    mapController.animateCamera(CameraUpdate.newLatLng(pos));
  }

  @override
  void initState() {
    super.initState();
    getCurrentDriverInfo(context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          padding: EdgeInsets.only(top: 135),
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          initialCameraPosition: googlePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
            mapController = controller;
            getCurrentPosition();
          },
        ),
        Positioned(
          child: Container(
            height: 135,
            width: double.infinity,
            color: BrandColors.colorPrimary,
            child: Center(
              child: AvailabilityButton(
                title: availabilityTitle,
                color: availabilityColor,
                onPressed: () async {
                  if (await Permission
                      .locationWhenInUse.serviceStatus.isEnabled) {
                    showModalBottomSheet(
                      isDismissible: false,
                      context: context,
                      builder: (BuildContext context) => ConfirmSheet(
                        title: (!isAvailable) ? 'تفعيل' : 'إنهاء',
                        subtitle: (!isAvailable)
                            ? 'يمكنك الان استقبال طلبات توصيل الاجرار'
                            : 'سوف تتوقف عن استقبال طلبات توصيل الاجرار',
                        onPressed: () {
                          if (!isAvailable && tripRequestRef != null) {
                            GoOnline();
                            getLocationUpdates();
                            setState(() {
                              availabilityColor = Colors.red;
                              availabilityTitle = 'إنهاء';
                              isAvailable = true;
                            });
                            driversIsAvailableRef.set(isAvailable);
                            Navigator.pop(context);
                          } else {
                            GoOffline();
                            Navigator.pop(context);
                            setState(() {
                              availabilityColor = BrandColors.colorAccent1;
                              availabilityTitle = 'تفعيل';
                              isAvailable = false;
                            });
                            driversIsAvailableRef.set(isAvailable);
                          }
                        },
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => PermissionLocation(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  void getLocationUpdates() {
    homeTabPositionStream = geoLocator
        .getPositionStream(locationOptions)
        .listen((Position position) {
      currentPosition = position;

      if (isAvailable) {
        Geofire.setLocation(
            currentFirebaseUser.uid, position.latitude, position.longitude);
      }

      LatLng pos = LatLng(position.latitude, position.longitude);
      mapController.animateCamera(CameraUpdate.newLatLng(pos));
    });
  }
}
