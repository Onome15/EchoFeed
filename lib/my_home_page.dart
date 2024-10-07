import 'package:app/news_feed.dart';
import 'package:app/notification_page.dart';
import 'package:app/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class MyHome extends StatelessWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;
  final Uint8List? profileImage;

  const MyHome({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(
        userName: userName,
        fullName: fullName,
        age: age,
        email: email,
        phoneNumber: phoneNumber,
        gender: gender,
        profileImage: profileImage,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;
  final Uint8List? profileImage;

  const MyHomePage({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.profileImage,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  late List<Widget> _pages;
  late List<String> _titles;
  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(
        fullName: widget.fullName,
        profileImage: widget.profileImage,
      ),
      const Notification(),
      Profile(
        userName: widget.userName,
        fullName: widget.fullName,
        age: widget.age,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
        gender: widget.gender,
        profileImage: widget.profileImage,
      ),
    ];

    // Titles for each page
    _titles = <String>[
      'EchoFeed',
      'Notifications',
      'Profile',
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_selectedIndex],
            style: const TextStyle(color: Colors.white)),
        // automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo, // AppBar color
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.indigo,
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

// Home Page Widget
class HomePage extends StatefulWidget {
  final String fullName;
  final Uint8List? profileImage;
  const HomePage({
    super.key,
    required this.fullName,
    required this.profileImage,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Newsfeed(
        fullName: widget.fullName,
        profileImage: widget.profileImage,
      ),
    );
  }
}

// Search Page Widget
class Notification extends StatelessWidget {
  const Notification({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: NotificationPage(),
    );
  }
}

class Profile extends StatefulWidget {
  final String userName; // Accept userName
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;
  final Uint8List? profileImage;

  const Profile({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    required this.profileImage,
  });
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfilePage(
        userName: widget.userName,
        fullName: widget.fullName,
        age: widget.age,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
        gender: widget.gender,
        profileImage: widget.profileImage,
      ),
    );
  }
}
