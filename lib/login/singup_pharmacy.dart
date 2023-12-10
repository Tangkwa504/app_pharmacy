import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_pharmacy/generated/assets.gen.dart';
import 'package:app_pharmacy/login/bloc/authentication_bloc.dart';
import 'package:app_pharmacy/login/sign_up_successful_screen.dart';
import 'package:app_pharmacy/widgets/base_upload_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:map_location_picker/map_location_picker.dart';

import '../firebase_options.dart';
import '../widgets/Service.dart';
import 'login_screen.dart';

//ตั้งชื่อตัวแปรต่างๆที่จะนำไปใช้
String Email = "";
String Password = "";
String Name = "";
String Licensepharmacy = "";
String Tel = "";
String Password2 = "";
String Nameshop = "";
String Addressshop = "";
String Timeopening = "";
String Timeclosing = "";
XFile? imgLiences;
XFile? imgLiencesStore;
XFile? imgQRcode;

late double lat;
late double long;

class singupmixpharmacy extends StatefulWidget {
  static const routeName = 'singupmixpharmacy';

  const singupmixpharmacy({super.key});

  @override
  State<singupmixpharmacy> createState() => _singupmixpharmacyState();
}

class _singupmixpharmacyState extends State<singupmixpharmacy> {
  TextEditingController Emailinput =
      TextEditingController(); // ตั้งค่าชื่อตัวแปรที่รับจากผู้ใช้
  TextEditingController Emailchack = TextEditingController();
  TextEditingController UserPass = TextEditingController();
  TextEditingController Checkpass = TextEditingController();
  ImagePicker _picker = ImagePicker();
  bool iserror = false;
  bool iserror2 = false;
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    print("test");
    if (pickedFile != null) {
      List<File> images = [];
      File imageFile = File(pickedFile.path);
      images.add(imageFile);
      ProviderSer profileService =
          Provider.of<ProviderSer>(context, listen: false);
      profileService.addFile(images);
    }
  }

  bool isValidEmail(String email) {
    // ใช้ Regular Expression เพื่อตรวจสอบรูปแบบอีเมล
    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    ProviderSer profiletestService =
        Provider.of<ProviderSer>(context, listen: false);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                print(profiletestService.imagesFile2 != null);
                await _pickImage();
                setState(() {});
              },
              child: Align(
                  alignment: Alignment.center,
                  child: profiletestService.imagesFile2 != null
                      ? Image.file(profiletestService.imagesFile2!,
                          width: 200, height: 220)
                      : Image.asset('assets/addphoto.png',
                          width: 200, height: 220)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Emailinput,
                keyboardType: TextInputType.emailAddress,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Email address",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: UserPass,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Checkpass,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "Confirm Password",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                String user = Emailinput.text.trim();
                if (!isValidEmail(user)) {
                  Fluttertoast.showToast(
                    msg: "ประเภทของอีเมลที่ใช้สมัครไม่ถูกต้อง",
                    gravity: ToastGravity.TOP,
                  );
                  return;
                }
                DatabaseReference starCountRef =
                    FirebaseDatabase.instance.ref('Pharmacy');
                starCountRef.onValue.listen((DatabaseEvent event) {
                  final data = event.snapshot.value;
                  Map<String, dynamic> map = json.decode(json.encode(data));
                  print("this is value from user : $user");
                  map.forEach(
                    (key, value) {
                      print("this is value from firebase : ${value['Email']}");
                      if (user == value["Email"].toString()) {
                        //เช็คเมล userlogin
                        setState(() {
                          iserror = true;
                        });
                        print("$iserror = Iserror");
                        print("value has been set true");
                      } else {
                        setState(() {
                          iserror = false;
                        });
                      }
                    },
                  );
                });
                Timer(const Duration(seconds: 1), () {
                  print("value bool : $iserror");
                  if (iserror) {
                    Fluttertoast.showToast(
                        msg: "อีเมลถูกใช้งานแล้ว", gravity: ToastGravity.TOP);
                    return;
                  }
                  if (Emailinput.text.isNotEmpty &&
                      UserPass.text.isNotEmpty &&
                      Checkpass.text.isNotEmpty &&
                      UserPass.text == Checkpass.text) {
                    Email = Emailinput.text;
                    Password = UserPass.text;
                    Navigator.of(context).pushNamed(singupmix2.routeName);
                  } else if (UserPass.text != Checkpass.text) {
                    Fluttertoast.showToast(
                        msg: "รหัสผ่านไม่ตรงกัน", gravity: ToastGravity.TOP);
                  } else {
                    Fluttertoast.showToast(
                        msg: "โปรดกรอกข้อมูลให้ครบถ้วน",
                        gravity: ToastGravity.TOP);
                  }
                });
              },
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color.fromARGB(255, 243, 16, 72),
                ),
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class singupmix2 extends StatefulWidget {
  static const routeName = 'singupmix2';

  const singupmix2({super.key});

  @override
  State<singupmix2> createState() => _singupmix2State();
}

//enum เป็นตัวแปลคล้ายๆบูลีน
class _singupmix2State extends State<singupmix2> {
  TextEditingController Fullname = TextEditingController();
  TextEditingController Pharmacylicense = TextEditingController();
  TextEditingController UserTel = TextEditingController();
  XFile? _file;

  @override
  void initState() {
    initfirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text(
              "Register",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Fullname,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Name",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Pharmacylicense,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Pharmacy License",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: UserTel,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Tel:",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            BaseUploadImage(
              label: 'รูปใบอนุญาต',
              onUpload: (file) async {
                setState(() {
                  _file = file;
                });
              },
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (Fullname.text.isNotEmpty &&
                    Pharmacylicense.text.isNotEmpty &&
                    UserTel.text.isNotEmpty &&
                    _file != null) {
                  Name = Fullname.text;
                  Licensepharmacy = Pharmacylicense.text;
                  Tel = UserTel.text;
                  imgLiences = _file;
                  Navigator.of(context).pushNamed(singupmix3.routeName);
                } else {
                  Fluttertoast.showToast(
                      msg: "โปรดกรอกข้อมูลให้ครบถ้วน",
                      gravity: ToastGravity.TOP);
                }
                // Name = Fullname.text;
                // Address = UserAddress.text;
                // Tel = UserTel.text;
                // Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),));
              },
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 243, 16, 72),
                ),
                child: const Text(
                  "NEXT",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already have an account?",
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LoginScreen())));
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class singupmix3 extends StatefulWidget {
  static const routeName = 'singupmix3';

  const singupmix3({super.key});

  @override
  State<singupmix3> createState() => _singupmix3State();
}

//enum เป็นตัวแปลคล้ายๆบูลีน
class _singupmix3State extends State<singupmix3> {
  TextEditingController Shopname = TextEditingController();
  TextEditingController Shopaddress = TextEditingController();
  TextEditingController Openingtime = TextEditingController();
  TextEditingController Closingtime = TextEditingController();
  TextEditingController licensesStore = TextEditingController();
  XFile? fileLicenseStore;
  XFile? fileQrCode;
  //ImagePicker _picker = ImagePicker();
  ImagePicker _pickershop = ImagePicker();
  Position? userLocation;
  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   print("test");
  //   if (pickedFile != null) {
  //     List<File> images = [];
  //     File imageFile = File(pickedFile.path);
  //     images.add(imageFile);
  //     ProviderSer profileService =
  //         Provider.of<ProviderSer>(context, listen: false);
  //     profileService.addFile(images);
  //   }
  // }

  Future<void> _pickImageshop() async {
    final pickedFile = await _pickershop.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      List<File> images = [];
      File imageFile = File(pickedFile.path);
      images.add(imageFile);
      ProviderSer profileService =
          Provider.of<ProviderSer>(context, listen: false);
      profileService.addFileshop(images);
    }
  }

  Future<void> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    userLocation = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    initfirebase();
    _getLocation();
    super.initState();
  }

  /* void getLo() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    userLocation = await Geolocator.getCurrentPosition();
  } */

  @override
  Widget build(BuildContext context) {
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black87),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              "Shop Detail",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 32,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            // Align(alignment: Alignment.center, child: Image.asset('assets/logo.png', width: 200)),
            const SizedBox(height: 12),
            InkWell(
              onTap: () async {
                print(profileService.imagesFile2shop != null);
                await _pickImageshop();
                setState(() {});
              },
              child: Align(
                  alignment: Alignment.center,
                  child: profileService.imagesFile2shop != null
                      ? Image.file(profileService.imagesFile2shop!,
                          width: 200, height: 220)
                      : Image.asset('assets/addphoto.png',
                          width: 200, height: 220)),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Shopname,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Shopname",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MapLocationPicker(
                        apiKey: "AIzaSyAqyETt9iu7l5QioWz5iwEbzrallQrpzLs",
                        popOnNextButtonTaped: true,
                        currentLatLng: LatLng(
                            userLocation!.latitude, userLocation!.longitude),
                        onNext: (GeocodingResult? result) {
                          if (result != null) {
                            Location latlong = result.geometry.location;
                            setState(() {
                              print(
                                  "1=============> ${result.formattedAddress}");
                              Shopaddress.text =
                                  result.formattedAddress.toString();
                              print("=============> ${latlong.lat}");
                              print("=============> ${latlong.lng}");
                              lat = latlong.lat;
                              long = latlong.lng;
                            });
                          }
                        },
                        onSuggestionSelected: (PlacesDetailsResponse? result) {
                          if (result != null) {
                            setState(() {
                              print(result.result.geometry!.location);
                              result.result.formattedAddress ?? "";
                            });
                          }
                        },
                      );
                    },
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.4),
                ),
                child: TextField(
                  enabled: false,
                  controller: Shopaddress,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: "Shopaddress",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Openingtime,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Openingtime",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: Closingtime,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "Closingtime",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey.withOpacity(0.4),
              ),
              child: TextField(
                controller: licensesStore,
                textAlignVertical: TextAlignVertical.center,
                decoration: const InputDecoration(
                  hintText: "License Store",
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: BaseUploadImage(
                label: 'รูปใบอนุญาต',
                onUpload: (file) async {
                  setState(() {
                    fileLicenseStore = file;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: BaseUploadImage(
                label: 'QRcode รับเงิน',
                onUpload: (file) async {
                  setState(() {
                    fileQrCode = file;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                if (Shopname.text.isNotEmpty &&
                    Shopaddress.text.isNotEmpty &&
                    Openingtime.text.isNotEmpty &&
                    Closingtime.text.isNotEmpty &&
                    fileQrCode != null &&
                    fileLicenseStore != null) {
                  Nameshop = Shopname.text;
                  Addressshop = Shopaddress.text;
                  Timeopening = Openingtime.text;
                  Timeclosing = Closingtime.text;
                  imgLiencesStore = fileLicenseStore;
                  imgQRcode = fileQrCode;
                  updata(profileService, context);
                  Fluttertoast.showToast(
                      msg: "Insert Success", gravity: ToastGravity.TOP);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    SignUpSuccessfulScreen.routeName,
                    (route) => false,
                  );
                } else {
                  Fluttertoast.showToast(
                      msg: "โปรดกรอกข้อมูลให้ครบถ้วน",
                      gravity: ToastGravity.TOP);
                }
              },
              child: Container(
                width: 400,
                height: 50,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(255, 243, 16, 72),
                ),
                child: const Text(
                  "REGISTER",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

bool checkemail(String user) {
  bool iserror = false;
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
  starCountRef.onValue.listen((DatabaseEvent event) {
    final data = event.snapshot.value;
    Map<String, dynamic> map = json.decode(json.encode(data));
    map.forEach(
      (key, value) {
        if (user == value["Email"].toString()) {
          //เช็คเมล userlogin
          iserror = true;
        }
      },
    );
  });
  return iserror;
}

void initfirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

void writefirebase(ProviderSer provider, BuildContext context) async {
  String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String rendomString = getRandomString(10);
  String path = "Pharmacy/${rendomString}";

  final licensesPhamarcyUrl = await context
      .read<AuthenticationBloc>()
      .uploadLicensesPhamarcy(imgLiences);

  // ignore: use_build_context_synchronously
  final licensesPhamarcyStoreUrl = await context
      .read<AuthenticationBloc>()
      .uploadLicensesPhamarcyStore(imgLiencesStore);

  final qrcodeUrl =
      // ignore: use_build_context_synchronously
      await context.read<AuthenticationBloc>().uploadQRCode(imgQRcode);

  DatabaseReference ref = FirebaseDatabase.instance.ref(path);

  await ref.set({
    "Email": Email,
    "Password": Password,
    "Licensepharmacy": Licensepharmacy,
    "img_license_url": licensesPhamarcyUrl,
    "img_license_store_url": licensesPhamarcyStoreUrl,
    "img_qr_code": qrcodeUrl,
    "Name": Name,
    "Tel": Tel,
    "Nameshop": Nameshop,
    "Addressshop": Addressshop,
    "Timeopening": Timeopening,
    "Timeclosing": Timeclosing,
    "latitude": lat,
    "longitude": long,
    "Id": rendomString,
    "requset": [
      {"email": "testmail", "status": 1},
      {"email": "testmail2", "status": 0}
    ],
    "status": "waiting",
    "profile_img_url": '',
  });
  provider.setemail(Email, rendomString);
  provider.uploadImages();
  provider.uploadImagesshop();
  provider.createcol(Email);
}

void updata(ProviderSer provider, BuildContext context) {
  writefirebase(provider, context);
}
