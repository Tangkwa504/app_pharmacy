import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseReference _database = FirebaseDatabase.instance.ref('Pharmacy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // สร้างอาเรย์ข้อมูล
            var dataArray = [1, 2, 3, 4, 5];

            // เพิ่มข้อมูลลงใน Firebase Realtime Database
            _database.child('Pharmacy').set(dataArray);
          },
          child: Text('เพิ่มข้อมูลอาเรย์ลงใน Firebase'),
        ),
      ),
    );
  }
}
