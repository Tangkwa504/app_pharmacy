// import 'package:app_pharmacy/chat/chat.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../widgets/Service.dart';

// class chatdm extends StatefulWidget {
//   @override
//   _chatdmState createState() => _chatdmState();
// }

// class _chatdmState extends State<chatdm> {
  
//     String sender = "";
//     String receiver = "";
//     String room = "";
//     List<String> chatKeys = [];
//     List msg = [];
//     List<DirectMessage> dmList = [];



//   // List<DirectMessage> dmList = [
//   //   DirectMessage(
//   //     userId: 'user2',
//   //     username: 'User 2',
//   //     senderId: 'test',
//   //     userImage:
//   //         'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
//   //   ),
//   //   // เพิ่มรายชื่อ DMs ตามต้องการ
//   // ];
//    @override
//  void didChangeDependencies() {
//   ProviderSer profileService = Provider.of<ProviderSer>(context, listen: true);
//   DatabaseReference chatRef = FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/chat');
//   sender = profileService.readid;
//   chatRef.onValue.listen((DatabaseEvent event) {
//     if (event.snapshot.exists) {
//       Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;
      
//       List<String> receiverList = data.keys.toList().cast<String>(); // แปลงคีย์ใน Map ให้เป็น List
      
//       // ตรวจสอบว่ารายการไม่ว่าง
//       if (receiverList.isNotEmpty) {
//         print("receiverList = $receiverList");
//         ondmcreated(receiverList);
//       }

//     }
    
//   });
//   super.didChangeDependencies();
// }

//   void ondmcreated(receiverList){
//     DatabaseReference starCountRef = FirebaseDatabase.instance.ref('User');
//   starCountRef.onValue.listen((DatabaseEvent event) {
//   if (event.snapshot.exists) {
//     Map<dynamic, dynamic> data = (event.snapshot.value ?? {}) as Map<dynamic, dynamic>;
//     data.forEach((key, value) async {
//       String dmEmail = value['Email'];
//       String dmId = value['Id'];
//       String dmusername  = value['Name'];
//       ProviderSer profileService =
//         Provider.of<ProviderSer>(context, listen: false);
//         String? url = await profileService.getProfileshopImageUrl(dmEmail);

//       createdm(dmId,dmEmail,dmusername,url);
//       print('Added marker with id=$dmId, dmEmail=$dmEmail, dmusername=$dmusername');
//       //getroom(receiverList);
//   });
//     }
//   });
// }
//   void createdm(String id,String email,String name,String? url){
//     List<DirectMessage> dmcreate = [
//     DirectMessage(
//       userId: id,
//       username: name,
//       senderId: email,
//       userImage: url ?? 'https://i.natgeofe.com/n/548467d8-c5f1-4551-9f58-6817a8d2c45e/NationalGeographic_2572187_square.jpg',
//     ),
//     // เพิ่มรายชื่อ DMs ตามต้องการ
//   ];
//   dmList.addAll(dmcreate);
//   print("dmlist === ${dmList}");
//   }

// void getroom(receiverList) {
//   ProviderSer profileService = Provider.of<ProviderSer>(context, listen: true);
//     DatabaseReference starCountRef =
//         FirebaseDatabase.instance.ref('Pharmacy/${profileService.readid}/chat/${receiverList}');
//     starCountRef.onValue.listen((DatabaseEvent event) {
//       print(event.snapshot.value);
//       String checkroom = "${event.snapshot.value.toString()}";
//       if(checkroom == "null"){
        
//       }else{
//       room = event.snapshot.value.toString();

//       getmsg();
//       }
//     });
//   }

//   void getmsg() {
//     DatabaseReference starCountRef = FirebaseDatabase.instance.ref('chatroom/$room/message');
//     starCountRef.onValue.listen((DatabaseEvent event) {
//       print("event getmsg"+"${event.snapshot.value}");
//       msg = event.snapshot.value as List;
//       print("List ${msg}");
//       setState(() {});
//     });
//   }

//   // void sendMesg() async {
//   //   DatabaseReference ref = FirebaseDatabase.instance.ref("chatroom/$room/message/${msg.length}");

//   //   await ref.set({
//   //     "msg": messageController.text,
//   //     "sender": widget.senderId,
//   //     "receiver": widget.receiverId,
//   //     "time": 1694937735,
//   //   });
//   //   messageController.clear();
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('ประวัติการสนทนา'),
//       ),
//       body: ListView.builder(
//         itemCount: dmList.length,
//         itemBuilder: (context, index) {
//           final dm = dmList[index];
//           return ListTile(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ChatScreen(
//                     receiverId: dm.userId,
//                     chatName: dm.username,
//                     image: dm.userImage,
//                     senderId: dm.senderId,
//                   ),
//                 ),
//               );
//             },
//             leading: CircleAvatar(
//               backgroundImage: NetworkImage(dm.userImage),
//             ),
//             title: Text(dm.username),
//             subtitle: Text("dm.lastMessage"),
//             trailing: Text("dm.lastMessageTime"),
//           );
//         },
//       ),
//     );
//   }
// }



// class DirectMessage {
//   final String userId;
//   final String username;
//   final String userImage;
//   final String senderId;

//   DirectMessage({
//     required this.userId,
//     required this.username,
//     required this.userImage,
//     required this.senderId,
//   });
// }
