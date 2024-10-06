import 'package:flutter/material.dart';
import 'package:app/my_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:typed_data';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';

  Future<void> _login() async {
    final enteredUsername = _usernameController.text;
    final enteredPassword = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUsername = prefs.getString('username');
    String? savedPassword = prefs.getString('password');
    String? name = prefs.getString('name');
    String? number = prefs.getString('number');
    String? email = prefs.getString('email');
    String? age = prefs.getString('age');
    String? gender = prefs.getString('gender');
    String? base64Image = prefs.getString('profileImage');

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      // Login success, pass the details to the ProfilePage
      if (!mounted) return;
      Uint8List? profileImage;
      if (base64Image != null) {
        setState(() {
          profileImage = base64Decode(
              base64Image); // Decode the base64 string to Uint8List
        }); // Decode base64 to bytes
      }
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHome(
            userName: savedUsername!,
            fullName: name!,
            age: int.parse(age!),
            phoneNumber: number!,
            email: email!,
            gender: gender!,
            profileImage: profileImage,
          ),
        ),
      );
    } else {
      // Login failed
      setState(() {
        _errorMessage = 'Invalid username or password';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Login'),
                ),
                if (_errorMessage.isNotEmpty)
                  Text(
                    _errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
