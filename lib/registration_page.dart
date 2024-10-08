import 'package:app/registration_page_helper.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EchoFeed',
      home: RegPage(),
    );
  }
}

class RegPage extends StatelessWidget {
  const RegPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            backIcon(),
            const Text(
              "Create an account",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.indigo,
      ),
      body: const Center(
        child: RegistrationPageHelper(),
      ),
    );
  }

  IconButton backIcon() {
    return IconButton(
      onPressed: () {
        // Navigating Back
        navigatorKey.currentState?.pop();
      },
      icon: const Icon(Icons.arrow_back),
      iconSize: 20,
    );
  }
}
