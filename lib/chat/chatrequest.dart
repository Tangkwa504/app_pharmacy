import 'dart:async';

import 'package:app_pharmacy/chat/chat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Service.dart';

class chatdmrequest extends StatefulWidget {
  @override
  _chatdmrequestState createState() => _chatdmrequestState();
}

class _chatdmrequestState extends State<chatdmrequest> {
  
    String sender = "";
    String receiver = "";
    String room = "";
    List<String> chatKeys = [];
    List msg = [];
    List<DirectMessage> dmList = [];
    late DatabaseReference chatRef ;
    late StreamSubscription<DatabaseEvent> subscription ;


   @override
   void initState() {
    Start();
    // TODO: implement initState
    super.initState();
  }
 void Start() {
  
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  chatRef = FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/request');
  sender = profileService.readid;
  print("sender === $sender");
  subscription = chatRef.onValue.listen((DatabaseEvent event) {
    if (event.snapshot.exists) {
      Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;
      print("data === $data");
      List<String> receiverList = data.keys.toList().cast<String>(); // แปลงคีย์ใน Map ให้เป็น List
      
      // ตรวจสอบว่ารายการไม่ว่าง
      if (receiverList.isNotEmpty) {
        print("receiverList = $receiverList");
        ondmcreated(receiverList);
 
      }

    }
    
  });
  
}

  Future<void> ondmcreated(List<String> receiverList) async {
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  sender = profileService.readid;

  for (String receiver in receiverList) {
    String receiverPath = 'User/$receiver';
    DatabaseReference starCountRef = FirebaseDatabase.instance.ref(receiverPath);

    try {
      DatabaseEvent event = await starCountRef.once();
      if (event.snapshot.exists) {
        Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;

        String dmEmail = data['Email'];
        String dmId = data['Id'];
        String dmusername = data['Name'];
        String? url = await profileService.getProfilechatImageUrl(dmEmail);

        createdm(dmId, dmEmail, dmusername, sender, url);
        print('createdm with id=$dmId, dmEmail=$dmEmail, dmusername=$dmusername, Pic=$url, Sender=$sender');
      }
    } catch (error) {
      // Handle any errors that might occur during the data retrieval.
      print('Error: $error');
    }
  }
}
  void createdm(String id,String email,String name,String sender,String? url){
    List<DirectMessage> dmcreate = [
    DirectMessage(
      userId: id,
      receiverId:email,
      username: name,
      senderId: sender,
      userImage: url ?? 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
      email:email,
    ),
    // เพิ่มรายชื่อ DMs ตามต้องการ
  ];
    setState(() {
    dmList.addAll(dmcreate);
    });

  print("dmlist === ${dmList}");
  }

  void deleteAndOpenChat(DirectMessage dm){
  deleteRequestafteraccept(dm.userId,dm);
   
   
  }
  void openChatScreen(DirectMessage dm) {

  // ใช้ Navigator.push เพื่อนำทางไปยังหน้าแชท
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ChatScreen(
        receiverId: dm.userId,
        chatName: dm.username,
        image: dm.userImage,
        senderId: dm.senderId,
        email:dm.email,
      ),
    ),
  );
}

void deleteRequestafteraccept(String userId,DirectMessage dm) {
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  DatabaseReference requestRef = FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/request/$userId');
  requestRef.remove().then((_) {
    setState(() {
      // ลบสำเร็จ
      // หน่วงเวลา 1 วินาทีก่อนรีเฟรชหน้า chatdmrequest
    Future.delayed(Duration(seconds: 1), () {
      // เรียก Navigator.pushReplacement เพื่อเปลี่ยนหน้าและรีเฟรชหน้า chatdmrequest
     openChatScreen(dm);
    });
    });
    
  }).catchError((error) {
    // ไม่สามารถลบข้อมูลได้
    print('เกิดข้อผิดพลาดในการลบข้อมูล: $error');
  });
}
void deleteRequest(String userId) {
  ProviderSer profileService = Provider.of<ProviderSer>(context, listen: false);
  DatabaseReference requestRef = FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/request/$userId');
  requestRef.remove().then((_) {
    setState(() {
      // ลบสำเร็จ
      // หน่วงเวลา 1 วินาทีก่อนรีเฟรชหน้า chatdmrequest
    Future.delayed(Duration(seconds: 1), () {
      // เรียก Navigator.pushReplacement เพื่อเปลี่ยนหน้าและรีเฟรชหน้า chatdmrequest
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => chatdmrequest()));
    });
    });
    
  }).catchError((error) {
    // ไม่สามารถลบข้อมูลได้
    print('เกิดข้อผิดพลาดในการลบข้อมูล: $error');
  });
}


@override
  void dispose() {
    // subscription.cancel();

    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('คำขอรับการปรึกษา'),
      ),
      body: ListView.builder(
  itemCount: dmList.length,
  itemBuilder: (context, index) {
    final dm = dmList[index];
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        ListTile(
          onTap: () {
            //gotochatandddelreq(dm);

          },
          leading: CircleAvatar(
            backgroundImage: NetworkImage(dm.userImage),
          ),
          title: Text(dm.username),
          subtitle: Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                   deleteAndOpenChat(dm);
                   
                  // โค้ดเมื่อกดปุ่มตอบรับ
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
                child: Text(
                  "ตอบรับ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(width: 35), // เพิ่มระยะห่างระหว่างปุ่ม
              ElevatedButton(
                onPressed: () {
                   deleteRequest(dm.userId);
                  // โค้ดเมื่อกดปุ่มปฏิเสธ
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
                child: Text(
                  "ปฏิเสธ",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          height: 1.5, // ปรับความสูงเพื่อเปลี่ยนความหนาของเส้น
          color: Color.fromARGB(255, 131, 130, 130), // สีของเส้น
        ), // เพิ่มเส้นขีด
      ],
    );
  },
)

    );
  }
}



class DirectMessage {
  final String userId;
  final String username;
  final String userImage;
  final String senderId;
  final String receiverId;
  final String email;

  DirectMessage({
    required this.userId,
    required this.username,
    required this.userImage,
    required this.senderId,
    required this.receiverId,
    required this.email,
  });
}
