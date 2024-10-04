import 'package:app/news_feed.dart';
import 'package:app/notification_page.dart';
import 'package:app/profile_page.dart';
import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;

  const MyHome({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
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

  const MyHomePage({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  late List<Widget> _pages;
  late List<String> _titles;
  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      HomePage(
        fullName: widget.fullName,
      ),
      const Notification(),
      Profile(
        userName: widget.userName,
        fullName: widget.fullName,
        age: widget.age,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
        gender: widget.gender,
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
  const HomePage({super.key, required this.fullName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Newsfeed(
        fullName: widget.fullName,
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

  const Profile({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
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
      ),
    );
  }
}
