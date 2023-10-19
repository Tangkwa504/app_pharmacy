import 'package:flutter/material.dart';

class chatdm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Direct Messages'),
      ),
      body: ListView.builder(
        itemCount: dmList.length, // จำนวน DMs ที่มี
        itemBuilder: (context, index) {
          final dm = dmList[index];
          return ListTile(
            onTap: () {
              // เปิดหน้าแชทของ DM นี้
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    // ส่งข้อมูลผู้รับไปยังหน้าแชท
                    receiverId: dm.userId,
                    chatName: dm.username,
                    image: dm.userImage,
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: NetworkImage(dm.userImage),
            ),
            title: Text(dm.username),
            subtitle: Text(dm.lastMessage),
            trailing: Text(dm.lastMessageTime),
          );
        },
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String chatName;
  final String image;

  const ChatScreen({
    Key? key,
    required this.receiverId,
    required this.chatName,
    required this.image,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  List<String> chatMessages = [];

// void getchatdm() {
//     ProviderSer profileService =
//         Provider.of<ProviderSer>(context, listen: true);
//     String pathpharmacy = "User/${profileService.readid}/chat";
//     String pathuser ="Pharmacy/${widget.receiverId}/chat";
//     DatabaseReference refuser = FirebaseDatabase.instance.ref(pathuser);
//     DatabaseReference refpharmacy = FirebaseDatabase.instance.ref(pathpharmacy);
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
            SizedBox(width: 10),
            Text(widget.chatName),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatMessages.length, // จำนวนข้อความในแชท
              itemBuilder: (context, index) {
                final message = chatMessages[index];
                return ListTile(
                  title: Text(message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // ส่งข้อความ
                    String newMessage = messageController.text;
                    setState(() {
                      chatMessages.add(newMessage);
                    });
                    messageController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DirectMessage {
  final String userId;
  final String username;
  final String userImage;
  final String lastMessage;
  final String lastMessageTime;

  DirectMessage({
    required this.userId,
    required this.username,
    required this.userImage,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}

// ตัวอย่างรายชื่อ DMs
List<DirectMessage> dmList = [
  DirectMessage(
    userId: 'user1',
    username: 'User 1',
    userImage: 'https://example.com/user1.jpg',
    lastMessage: 'Hello there!',
    lastMessageTime: '10:30 AM',
  ),
  DirectMessage(
    userId: 'user2',
    username: 'User 2',
    userImage: 'https://example.com/user2.jpg',
    lastMessage: 'Hi!',
    lastMessageTime: '11:45 AM',
  ),
  // เพิ่มรายชื่อ DMs ตามต้องการ
];
