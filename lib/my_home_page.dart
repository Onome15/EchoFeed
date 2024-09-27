import 'package:flutter/material.dart';

class MyHome extends StatelessWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;

  const MyHome({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
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

  const MyHomePage({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 2;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      const HomePage(),
      const NotificationPage(),
      ProfilePage(
        userName: widget.userName,
        fullName: widget.fullName,
        age: widget.age,
        email: widget.email,
        phoneNumber: widget.phoneNumber,
      ), // Pass userName to ProfilePage
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
        title: const Text('App', style: TextStyle(color: Colors.white)),
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
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Home Page',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Search Page Widget
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Notification',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}

// Profile Page Widget
class ProfilePage extends StatefulWidget {
  final String userName; // Accept userName
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;

  const ProfilePage({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
  });
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          const CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/33576285?v=4'),
          ),
          const SizedBox(height: 10),
          Text('Username:',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.normal)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.userName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Icon(
                Icons.verified_user,
                color: Colors.indigo,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
              'I love teaching students and helping them to achieve their dreams.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 20),
          Card(
            elevation: 4.0,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.verified_user),
                  title: const Text('Name'),
                  subtitle: Text(widget.fullName),
                ),
                ListTile(
                  leading: const Icon(Icons.cake),
                  title: const Text('Age'),
                  subtitle: Text(widget.age.toString()),
                ),
                ListTile(
                    leading: const Icon(Icons.phone),
                    title: const Text(
                      'Phone Number',
                    ),
                    subtitle: Text(widget.phoneNumber),
                    onTap: () {}),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text(
                    'Email Address',
                  ),
                  subtitle: Text(widget.email),
                ),
                const ListTile(
                  leading: Icon(Icons.male),
                  title: Text('Gender'),
                  subtitle: Text('Male'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {},
                color: Colors.blue,
                tooltip: 'Facebook',
              ),
              IconButton(
                icon: const Icon(Icons.link),
                onPressed: () {},
                color: Colors.blue,
                tooltip: 'LinkedIn',
              ),
              IconButton(
                icon: const Icon(Icons.code),
                onPressed: () {},
                color: Colors.black,
                tooltip: 'GitHub',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
