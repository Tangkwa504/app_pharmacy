import 'package:app_pharmacy/generated/assets.gen.dart';
import 'package:app_pharmacy/profile/bloc/profile_bloc.dart';
import 'package:app_pharmacy/profile/bloc/state/profile_state.dart';
import 'package:app_pharmacy/profile/model/response/profile_information_response.dart';
import 'package:app_pharmacy/profile/page/change_password_screen.dart';
import 'package:app_pharmacy/profile/page/qr_code_screen.dart';
import 'package:app_pharmacy/profile/setting_profile.dart';
import 'package:app_pharmacy/profile/widgets/profile_menu_widget.dart';
import 'package:app_pharmacy/widgets/Service.dart';
import 'package:app_pharmacy/widgets/base_divider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../firebase_options.dart';
import '../first_page.dart';

import '../widgets/alertdialog.dart';

class ProfileArgs {
  final ProfileInformationResponse? profileInformation;

  ProfileArgs({
    this.profileInformation,
  });
}

class ProfilePage extends StatefulWidget {
  static const routeName = 'ProfilePage';

  String id;
  ProfilePage({required this.id, Key? key}) : super(key: ValueKey<String>(id));

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

List users = [];
String? url;

class _ProfilePageState extends State<ProfilePage> {
  @override
  DatabaseReference starCountRef = FirebaseDatabase.instance.ref('Pharmacy');

  void initState() {
    initfirebase();
    setimg();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<ProfileBloc>().onGetProfileInformation();
    });
    super.initState();
  }

  void setimg() async {
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: false);
    url = await profileService.getProfileImageUrl();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ProviderSer profileService =
        Provider.of<ProviderSer>(context, listen: true);
    final cartService = Provider.of<CartProvider>(context, listen: true);
    final productService = Provider.of<ProductProvider>(context, listen: true);
    final idprovoder = Provider.of<Useridprovider>(context, listen: true);
    // readfirebase();
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        final profileInformation = state.profileInformation;
        return SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Stack(
            children: [
              ClipPath(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(255, 224, 20, 214),
                        Color(0xff8F6ED5),
                        Color.fromARGB(255, 25, 128, 224),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 150,
                bottom: 30,
                right: 30,
                left: 30,
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    padding: const EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 100,
                          child: FirebaseAnimatedList(
                            padding: const EdgeInsets.only(top: 30),
                            query: starCountRef
                                .orderByChild("Email")
                                .equalTo(widget.id),
                            itemBuilder: (context, snapshot, animation, index) {
                              return Column(
                                children: [
                                  Text(
                                    snapshot.child("Name").value.toString(),
                                    style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    widget.id,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // Text(
                                  //   appservice.Emaillogin.text,
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     fontWeight: FontWeight.bold,
                                  //   ),
                                  // ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              ProfileMenuWidget(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    settingprofile.routeName,
                                    arguments: ProfileArgs(
                                      profileInformation: profileInformation,
                                    ),
                                  );
                                },
                                prefixImg: Assets.icHeart.svg(),
                                label: 'Edit Profile',
                              ),
                              const BaseDivider(),
                              ProfileMenuWidget(
                                onTap: () {},
                                prefixImg: Assets.icDocument.svg(),
                                label: 'แก้ไขข้อมูลร้าน',
                              ),
                              const BaseDivider(),
                              ProfileMenuWidget(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      QRCodeScreen.routeName,
                                      arguments: ProfileArgs(
                                          profileInformation:
                                              profileInformation));
                                },
                                prefixImg: Assets.icWallet.svg(),
                                label: 'แก้ไข QRcode',
                              ),
                              const BaseDivider(),
                              ProfileMenuWidget(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      ChangePasswordScreen.routeName,
                                      arguments: ProfileArgs(
                                          profileInformation:
                                              profileInformation));
                                },
                                prefixImg: Assets.icWallet.svg(),
                                label: 'เปลี่ยนรหัสผ่าน',
                              ),
                              const BaseDivider(),
                              ProfileMenuWidget(
                                onTap: () async {
                                  final action =
                                      await AlertDialogs.yesCancleDialog(
                                          context,
                                          'Logout',
                                          'คุณยืนยันที่จะออกจากระบบหรือไม่ ?');
                                  if (action == DialogAction.Yes) {
                                    Fluttertoast.showToast(
                                        msg: "ออกจากระบบเสร็จสิ้น",
                                        gravity: ToastGravity.TOP,
                                        backgroundColor: const Color.fromARGB(
                                            255, 243, 16, 72));
                                    profileService.logout();
                                    productService.logout();
                                    cartService.logout();
                                    idprovoder.logoutid();
                                    setState(() {
                                      url = null;
                                      widget.id = "";
                                    });
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const FirstPage(),
                                        ));
                                  }
                                },
                                prefixImg: Assets.icWarning.svg(),
                                label: 'ออกจากระบบ',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //image
              Positioned(
                top: 75,
                left: MediaQuery.of(context).size.width / 2 - 75,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: profileService.imgbyte != null
                      ? Image.memory(
                          profileService.imgbyte!,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          "assets/profile.png",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// void readfirebase(String nameuser) async {
//     DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
//     starCountRef.onValue.listen((DatabaseEvent event) {
//       final data = event.snapshot.value;
//       Map<String, dynamic> map = json.decode(json.encode(data));
//       print(map);
//       list = [];
//       map.forEach(
//         (key, value) {
//           String b = "${widget.id}";
//           for(int i = 0; i<list.length; i++){
//             if(b==value["Email"]){
//             nameuser = value["Name"];

//           };
//           }

//         },
//       );
//       list.forEach((element) {
//         print("$element");
//       });
//     });
//   }
}

void initfirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}
