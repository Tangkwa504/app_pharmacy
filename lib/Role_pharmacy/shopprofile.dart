// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Shopprofile extends StatefulWidget {
  Shopprofile({super.key, required this.Shopname, required this.Addressshop,
  required this.Pharmacyname,required this.Timeclosing,required this.Timeopening,required this.Url});

  String Shopname;
  String Addressshop;
  String Pharmacyname;
  String Timeopening;
  String Timeclosing;
  String? Url;

  @override
  State<Shopprofile> createState() => _ShopprofileState();
}

class _ShopprofileState extends State<Shopprofile> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดร้านขายยา'),
      ),
      body: Container(
         child: SingleChildScrollView(
          child: Column(
            children:  [
              const Text(
                  "",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
              ),
              const SizedBox(height: 12),
              Align(alignment: Alignment.center, child: Image.network(widget.Url.toString(), width: 200)),
              const SizedBox(height: 12),
              Text(
                  widget.Shopname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 64,
                    color: Colors.black87,
                  ),
              ),
              const SizedBox(height: 12),
              Text(
                  widget.Addressshop,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Colors.black87,
                  ),
              ),     
              const SizedBox(height: 12),
              Text(
                  widget.Timeopening+"-"+widget.Timeclosing,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: Color.fromARGB(221, 0, 47, 255),
                  ),
              ),     
              const SizedBox(height: 12),
              Text(
                  widget.Pharmacyname,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color.fromARGB(221, 95, 93, 93),
                  ),
              ),    
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage(),));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 243, 16, 72),
                  ),
                  child: const Text( 
                    "ปรึกษาเภสัชกร",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          
         ),
      ),
      
    );
    
  }
}