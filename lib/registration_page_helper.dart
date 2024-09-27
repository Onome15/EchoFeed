import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app/my_home_page.dart';

class RegistrationPageHelper extends StatelessWidget {
  const RegistrationPageHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Forms',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  final _userNameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  // final _genderController = TextEditingController();

  bool isValid = false;

  String? passwordErrorMessage;
  bool isPasswordValid = false;

  void _checkPassword(String value) {
    setState(() {
      if (value.isNotEmpty) {
        passwordErrorMessage =
            null; // Clear error as soon as user starts typing
      }
      if (value.length >= 6) {
        passwordErrorMessage = '';
        isPasswordValid = true;
      } else {
        passwordErrorMessage = 'Password must be at least 6 characters';
        isPasswordValid = false;
      }
    });
  }

  void _validateForm() {
    String passwordValue = _passwordController.text;
    if (!_formKey.currentState!.validate()) {
      setState(() {
        // If validation fails, trigger the error message
        passwordErrorMessage = passwordValue.isEmpty
            ? 'Password cannot be empty'
            : 'Password must be at least 6 characters';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _phoneNumberController.addListener(_validatePhoneNumber);
  }

  void _validatePhoneNumber() {
    setState(() {
      isValid = _phoneNumberController.text.length == 11;
    });
  }

  @override
  void dispose() {
    _phoneNumberController
        .dispose(); // Cleans up the controller when the widget is removed
    super
        .dispose(); // Calls the superclass dispose to ensure proper disposal of other inherited resources
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(10),
      width: 500,
      // height: max,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 245, 246, 247),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 247, 244, 244),
          width: 5, // Border thickness
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Create Account',
                  style: TextStyle(
                      fontSize: 25,
                      // color: Color.fromARGB(255, 241, 237, 237),
                      fontWeight: FontWeight.bold),
                ),
              ),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Full Name',
                  hintText: 'Enter your Full Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'User Name',
                  hintText: 'Enter your User Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Username';
                  } else if (value.contains(' ')) {
                    return 'Please remove space';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Age',
                  hintText: 'Enter your User Age',
                ),
                keyboardType: TextInputType.number,
                maxLength: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Age';
                  }
                  final int? age = int.tryParse(value);
                  if (age! <= 17) {
                    return 'Age must be above 17';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 5),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@') ||
                      !value.contains('.com') ||
                      value.contains(' ')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Phone Number',
                  hintText: 'Enter your Phone Number',
                  prefixIcon: const Icon(Icons.phone),
                  suffixIcon: isValid
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  } else if (value.length < 11) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Password',
                  suffixIcon: isPasswordValid
                      ? const Icon(Icons.check_circle, color: Colors.blue)
                      : null,
                ),
                obscureText: true,
                onChanged: _checkPassword,
              ),
              if (passwordErrorMessage != null) // Conditionally show error text
                Text(
                  passwordErrorMessage!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 169, 16, 5),
                    fontSize: 12,
                  ),
                ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Confirm Password',
                  hintText: 'Confirm Password',
                  suffixIcon: () {
                    if (_confirmPasswordController.text.length > 5 &&
                        _confirmPasswordController.text ==
                            _passwordController.text) {
                      return const Icon(Icons.check_circle, color: Colors.blue);
                    } else {
                      return null;
                    }
                  }(),
                ),
                onChanged: (value) {
                  setState(() {
                    // Triggers the UI rebuild based on the matching condition
                    // No extra logic needed here as the suffixIcon is updated automatically
                  });
                },
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  } else if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (isPasswordValid == true) {
                      if (_formKey.currentState!.validate()) {
                        String userName = _userNameController.text;
                        String fullName = _fullNameController.text;
                        int age = int.parse(_ageController.text);
                        String phoneNumber = _phoneNumberController.text;
                        String email = _emailController.text;
                        // String gender = _userName.text;

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Dear $userName, Your form has been successfully created'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => MyHome(
                                      userName: userName,
                                      fullName: fullName,
                                      age: age,
                                      phoneNumber: phoneNumber,
                                      email: email,
                                    )),
                          );
                        });
                      }
                    } else {
                      _validateForm();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
