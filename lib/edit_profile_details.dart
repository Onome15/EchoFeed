import 'package:flutter/material.dart';
import 'dart:typed_data';

class EditProfilePage extends StatefulWidget {
  final String userName;
  final String fullName;
  final int age;
  final String email;
  final String phoneNumber;
  final String gender;
  final Uint8List? profileImage;

  const EditProfilePage({
    super.key,
    required this.userName,
    required this.fullName,
    required this.age,
    required this.email,
    required this.phoneNumber,
    required this.gender,
    this.profileImage,
  });

  @override
  EditProfilePageState createState() => EditProfilePageState();
}

class EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController userNameController;
  late TextEditingController fullNameController;
  late TextEditingController ageController;
  late TextEditingController emailController;
  late TextEditingController phoneNumberController;
  late TextEditingController genderController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController(text: widget.userName);
    fullNameController = TextEditingController(text: widget.fullName);
    ageController = TextEditingController(text: widget.age.toString());
    emailController = TextEditingController(text: widget.email);
    phoneNumberController = TextEditingController(text: widget.phoneNumber);
    genderController = TextEditingController(text: widget.gender);
  }

  @override
  void dispose() {
    userNameController.dispose();
    fullNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    genderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: fullNameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Age'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneNumberController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: genderController,
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Collect the updated data and pass it back to the ProfilePage
                Navigator.pop(context, {
                  'userName': userNameController.text,
                  'fullName': fullNameController.text,
                  'age': int.parse(ageController.text),
                  'email': emailController.text,
                  'phoneNumber': phoneNumberController.text,
                  'gender': genderController.text,
                });
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
