import 'package:flutter/material.dart';
import 'dart:typed_data';

class ProfilePage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                const Text('Profile Picture:'),
                profileImage != null
                    ? Image.memory(
                        profileImage!, // Load the image from the bytes
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      )
                    : const CircleAvatar(
                        radius: 75,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 75),
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
                Text('Flutter Enthusiastic and Tech advocate',
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
                        subtitle: Text(fullName),
                      ),
                      ListTile(
                        leading: const Icon(Icons.cake),
                        title: const Text('Age'),
                        subtitle: Text(age.toString()),
                      ),
                      ListTile(
                          leading: const Icon(Icons.phone),
                          title: const Text(
                            'Phone Number',
                          ),
                          subtitle: Text(phoneNumber),
                          onTap: () {}),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text(
                          'Email Address',
                        ),
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
          ),
        ),
      ),
    );
  }
}
