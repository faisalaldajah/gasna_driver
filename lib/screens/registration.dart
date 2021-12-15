import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gasna_driver/datamodels/RegistrationData.dart';
import 'package:gasna_driver/screens/DistributionPlace.dart';
import 'package:gasna_driver/screens/StartPage.dart';
import 'package:gasna_driver/widgets/GradientButton.dart';
import 'package:gasna_driver/widgets/ProgressDialog.dart';
import 'package:image_picker/image_picker.dart';
import '../globalvariabels.dart';

class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var agentController = TextEditingController();

  var placeController = TextEditingController();

  var governorateController = TextEditingController();

  String title = 'التالي';
  var storage = FirebaseStorage.instance;
  File _imageId;
  File _ImageDefenseCard;
  List<File> _imageList = [];
  var url;
  Future getImageFromCamera() async {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        _ImageDefenseCard = File(pickedFile.path);
        // _imageList.add(_imageId);
      } else {
        print('No image selected.');
      }
    });
    if (_ImageDefenseCard != null) {
      storage
          .ref()
          .child(
              'drivers/${Uri.file(_ImageDefenseCard.path).pathSegments.last}.jpg')
          .putFile(_ImageDefenseCard)
          .catchError((e) {
        print(e);
      });
    }
  }

  Future getImageImageFromGallery() async {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _imageId = File(pickedFile.path);
        _imageList.add(_imageId);
      } else {
        print('No image selected.');
      }
    });
    if (_imageId != null) {
      storage
          .ref()
          .child('drivers/${Uri.file(_imageId.path).pathSegments.last}.jpg')
          .putFile(_imageId)
          .catchError((e) {
        print(e);
      });
    }
  }

  void registerUser() async {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'جاري تسجيل الحساب',
      ),
    );

    final User user = (await _auth
            .createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      //check error and display message
      Navigator.pop(context);
      showSnackBar('تحقق من الاسم او الرقم السري');
    }))
        .user;

    Navigator.pop(context);
    // check if user registration is successful
    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('drivers/${user.uid}');
      url = await storage
          .ref()
          .child(
              'drivers/${Uri.file(_ImageDefenseCard.path).pathSegments.last}.jpg')
          .getDownloadURL()
          .catchError((e) {
        print(e);
      });
      DatabaseReference checkDriverRef = FirebaseDatabase.instance
          .reference()
          .child('approveDriver/${user.uid}');
      //Prepare data to be saved on users table
      Map userMap = {
        'fullname': fullNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'driversIsAvailable': false,
        'agentName': agentController.text,
        'place': placeController.text,
        'approveDriver': 'false',
        'governorate': governorateController.text,
        'driverType': placeController.text,
        'currentAmount': '0',
        'defenseCard': url,
        'amount': {
          'amount': '0',
          'status': 'wait',
          'transNumber': '0',
        }
      };
      Map checkDriverMap = {
        'isApproveDriver': 'false',
      };
      newUserRef.set(userMap);
      checkDriverRef.set(checkDriverMap);
      setState(() {
        currentFirebaseUser = user;
        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        agentController.clear();
        governorateController.clear();
        placeController.clear();
        phoneController.clear();
        _ImageDefenseCard = null;
      });

      //Take the user to the mainPage
      RegistrationData registrationData;
      registrationData = RegistrationData(
        agentName: agentController.text,
        governorate: placeController.text,
        email: emailController.text,
        name: fullNameController.text,
        number: phoneController.text,
        passowrd: passwordController.text,
      );
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DistributionPlace(
            registrationData: registrationData,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Image(
                  alignment: Alignment.center,
                  height: 160.0,
                  width: 160.0,
                  image: AssetImage('images/gasna.png'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'تسجيل حساب جديد',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            // Fullname
                            TextField(
                              controller: fullNameController,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                  labelText: 'الاسم كامل',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Email Address
                            TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'الايميل',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Phone
                            TextField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                  labelText: 'رقم الهاتق',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            // Password
                            TextField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'رقم السري',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          children: [
                            TextField(
                              controller: agentController,
                              decoration: InputDecoration(
                                labelText: 'اسم الوكالة',
                                labelStyle: TextStyle(
                                  fontSize: 14.0,
                                ),
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 10.0),
                              ),
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextField(
                              controller: governorateController,
                              decoration: InputDecoration(
                                  labelText: 'المحافظة',
                                  labelStyle: TextStyle(
                                    fontSize: 14.0,
                                  ),
                                  hintStyle: TextStyle(
                                      color: Colors.grey, fontSize: 10.0)),
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: TextField(
                          controller: placeController,
                          decoration: InputDecoration(
                            labelText: 'مكان التوزيع',
                            labelStyle: TextStyle(
                              fontSize: 14.0,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 10.0,
                            ),
                          ),
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      /* SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: getImageFromCamera,
                          icon: Icon(Icons.camera_alt_outlined)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: (_imageId != null)
                            ? Image.file(_imageId)
                            : Text(
                                'قم بتصوير الهوية',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),*/
                      SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: getImageFromCamera,
                          icon: Icon(Icons.camera_alt_outlined)),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: (_ImageDefenseCard != null)
                            ? Image.file(_ImageDefenseCard)
                            : Text(
                                'قم بتصوير كرت الدفاع',
                                style: TextStyle(color: Colors.black),
                              ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GradientButton(
                        title: title,
                        onPressed: () async {
                          //check network availability
                          var connectivityResult =
                              await Connectivity().checkConnectivity();
                          if (connectivityResult != ConnectivityResult.mobile &&
                              connectivityResult != ConnectivityResult.wifi) {
                            showSnackBar('No internet connectivity');
                            return;
                          }
                          if (fullNameController.text.length < 3) {
                            showSnackBar('Please provide a valid fullname');
                            return;
                          }
                          if (phoneController.text.length < 10) {
                            showSnackBar('Please provide a valid phone number');
                            return;
                          }
                          if (!emailController.text.contains('@')) {
                            showSnackBar(
                                'Please provide a valid email address');
                            return;
                          }
                          if (passwordController.text.length < 8) {
                            showSnackBar(
                                'password must be at least 8 characters');
                            return;
                          }
                          registerUser();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
