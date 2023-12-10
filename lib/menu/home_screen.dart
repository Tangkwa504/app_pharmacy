import 'package:flutter/material.dart';

import '../Products/Cart.dart';

//import '../chat/chat.dart';

import 'home_page.dart';

import '../profile/profile_page.dart';

class HomeScreenArgs {
  final String id;

  HomeScreenArgs({
    required this.id,
  });
}

class HomeScreen extends StatefulWidget {
  static const routeName = 'HomeScreen';

  final HomeScreenArgs args;
  HomeScreen({required this.args, Key? key})
      : super(
          key: ValueKey<String>(args.id),
        );

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    String email = widget.args.id;
    final _kTabPages = <Widget>[
      const HomePage(),

      ProfilePage(id: email),
      //ChatScreen(chatName: 'test', image: 'test', receiverId: 'tktk', senderId:email ,email: "email",),
      CartScreen(),
      ProfilePage(id: email),
    ];
    final _kBottmonNavBarItems = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'หน้าหลัก'),
      const BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'ปรึกษา'),
      const BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart), label: 'ตระกร้า'),
      const BottomNavigationBarItem(icon: Icon(Icons.people), label: 'บัญชี'),
    ];
    assert(_kTabPages.length == _kBottmonNavBarItems.length);
    final bottomNavBar = BottomNavigationBar(
      items: _kBottmonNavBarItems,
      currentIndex: _currentTabIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (int index) {
        setState(() {
          _currentTabIndex = index;
        });
      },
    );
    return Scaffold(
      body: _kTabPages[_currentTabIndex],
      bottomNavigationBar: bottomNavBar,
    );
  }
}
