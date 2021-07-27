import 'package:firebase_database/firebase_database.dart';

class Driver {
  String fullName;
  String email;
  String phone;
  String id;
  String carModel;
  String carColor;
  String vehicleNumber;
  bool driversIsAvailable;
  Driver({
    this.fullName,
    this.email,
    this.phone,
    this.id,
    this.carModel,
    this.carColor,
    this.vehicleNumber,
    this.driversIsAvailable,
  });

  Driver.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullname'];
    carModel = snapshot.value['vehicle_details']['car_model'];
    carColor = snapshot.value['vehicle_details']['car_color'];
    vehicleNumber = snapshot.value['vehicle_details']['vehicle_number'];
    driversIsAvailable = snapshot.value['driversIsAvailable'];
  }
}
