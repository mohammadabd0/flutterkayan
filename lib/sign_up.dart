import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_task1/book_list.dart';
import 'package:flutter_application_task1/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'model/user.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  List<User> userList = [];
  bool isLoading = false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isValid = false;

 
  void saveUs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonbook = jsonEncode(userList);
    preferences.setString("user", jsonbook);
  }

  void saveUser() async {
    // Ensure the form is valid
    if (_formKey.currentState!.validate()) {
      String newUsername = usernameController.text;
      // Check if the username already exists
      if (doesUserExist(newUsername)) {
        // Show an error dialog since the username is already taken
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Username already exists'),
            content: Text('Please choose a different username.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
        return;
      }
    String userId = Uuid().v4();

      // Create a new User object
     User newUser = User(
      userId: userId,
      userName: newUsername,
      email: emailController.text,
      password: passwordController.text,
    );
      // Add the new user to the user list
      setState(() {
        userList.add(newUser);
      });

      // Save the updated user list to shared preferences
      saveUs();

      // Navigate to the MyBook page
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyBook()),
      );
    }
  }

  bool doesUserExist(String username) {
    return userList.any((user) => user.userName == username);
  }
void loadUserList() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String? jsonUserList = preferences.getString("user");
  if (jsonUserList != null && jsonUserList.isNotEmpty) {
    List<dynamic> decodedList = jsonDecode(jsonUserList);
    userList = decodedList.map((userMap) => User.fromJson(userMap)).toList();
  }
}
  @override
  void initState() {
    loadUserList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150),

              Text(
                'Create your Username ',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: usernameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Username',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: _isValid
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            setState(() {
                              _isValid = false;
                            });
                            return 'Please enter a username';
                          } else {
                            setState(() {
                              _isValid = true;
                            });
                            return null;
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: _isValid
                              ? Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        validator: (value) {
                          RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
                          if (value!.isEmpty) {
                            setState(() {
                              _isValid = false;
                            });
                            return 'Please enter a email';
                          } else if (!emailRegExp.hasMatch(value)) {
                            setState(() {
                              _isValid = false;
                            });
                            return 'Invalid email format';
                          }
                          setState(() {
                            _isValid = true;
                          });
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          suffixIcon: _isValid
                              ? const Icon(
                                  Icons.check,
                                  color: Colors.green,
                                )
                              : const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                        ),
                        validator: (value) {
                          RegExp passwordRegExp = RegExp(
                              r'^(?=.*?[A-Za-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{6,}$');

                          if (value!.isEmpty) {
                            setState(() {
                              _isValid = false;
                            });
                            return 'Please enter a password';
                          } else if (!passwordRegExp.hasMatch(value)) {
                            setState(() {
                              _isValid = false;
                            });
                            return 'Password must contain at least 6 characters, lowercase, numbers, and special characters';
                          }
                          setState(() {
                            _isValid = true;
                          });
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // sign in button

              GestureDetector(
                child: TextButton(
                  onPressed: () {
                    saveUser();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'are you a member',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () async {
                      var updatedUserList = await Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                LoginPage(userLists: userList)),
                      );

                      // Update the userList with the result from LoginPage
                      if (updatedUserList != null) {
                        setState(() {
                          userList = updatedUserList;
                        });
                      }
                    },
                    child: const Text(
                      'login',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
