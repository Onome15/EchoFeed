import 'package:app/registration_page_helper.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Navigation Demo',
      home: RegPage(),
    );
  }
}

class RegPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            backIcon(),
            const Text("Second Screen"),
          ],
        ),
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
