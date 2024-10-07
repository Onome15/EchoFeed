import 'package:app/edit_profile_details.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;
  final Uint8List? profileImage;

  const ProfilePage({
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
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  late String userName;
  late String fullName;
  late int age;
  late String email;
  late String phoneNumber;
  late String gender;
  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();

    userName = widget.userName;
    fullName = widget.fullName;
    age = widget.age;
    email = widget.email;
    phoneNumber = widget.phoneNumber;
    gender = widget.gender;
    profileImage = widget.profileImage;
  }

  Future<void> _launchURL(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Stack(children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        ClipOval(
                          child: profileImage != null
                              ? Image.memory(
                                  profileImage!, // Load the image from the bytes
                                  width: 120,
                                  height: 120,
                                  fit: BoxFit.cover,
                                )
                              : const CircleAvatar(
                                  radius: 75,
                                  backgroundColor: Colors.grey,
                                  child: Icon(Icons.person, size: 75),
                                ),
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
                              userName,
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
                        Text('Highly motivated software developer',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Edit') {
                            _editProfile(context);
                          } else if (value == 'Logout') {
                            logOut(context);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'Edit',
                            child: Text('Edit'),
                          ),
                          const PopupMenuItem(
                            value: 'Logout',
                            child: Text('Logout'),
                          ),
                        ],
                        icon: const Icon(Icons.more_vert),
                      )),
                ]),
                const SizedBox(height: 20),
                Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        leading: const Icon(Icons.verified_user),
                        title: const Text('Name'),
                        subtitle: Text(fullName),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text('Age'),
                        subtitle: Text(age.toString()),
                      ),
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: const Text('Phone Number'),
                        subtitle: Text(phoneNumber),
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Email Address'),
                        subtitle: Text(email),
                      ),
                      ListTile(
                        leading: const Icon(Icons.male),
                        title: const Text('Gender'),
                        subtitle: Text(gender),
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
                      onPressed: () => _launchURL(Uri.parse(
                          'https://web.facebook.com/profile.php?id=100070104341422')),
                      color: Colors.blue,
                      tooltip: 'Facebook',
                    ),
                    IconButton(
                      icon: const Icon(Icons.link),
                      onPressed: () => _launchURL(
                          Uri.parse('https://linkedin.com/in/orhero-onome/')),
                      color: Colors.blue,
                      tooltip: 'LinkedIn',
                    ),
                    IconButton(
                      icon: const Icon(Icons.code),
                      onPressed: () =>
                          _launchURL(Uri.parse('https://github.com/Onome15')),
                      color: Colors.black,
                      tooltip: 'GitHub',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to navigate to EditProfilePage
  void _editProfile(BuildContext context) async {
    // Wait for the result (updated profile) from the EditProfilePage
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProfilePage(
          userName: userName,
          fullName: fullName,
          age: age,
          email: email,
          phoneNumber: phoneNumber,
          gender: gender,
          profileImage: profileImage,
        ),
      ),
    );

    if (updatedProfile != null) {
      setState(() {
        // Update the profile details with the returned data
        userName = updatedProfile['userName'];
        fullName = updatedProfile['fullName'];
        age = updatedProfile['age'];
        email = updatedProfile['email'];
        phoneNumber = updatedProfile['phoneNumber'];
        gender = updatedProfile['gender'];
      });
    }
  }

  Future<dynamic> logOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: const Text('Logout of EchoFeed?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainScreen(),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
