import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_task1/book_list.dart';
import 'package:flutter_application_task1/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'model/user.dart';

class LoginPage extends StatefulWidget {
  List<User> userLists;

  LoginPage({required this.userLists, super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
    bool newuser =false;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  // Check if a user exists based on their username
  bool doesUserExist(String username, List<User> userList,) {
    return userList.any((user) => user.userName == username );
  }


  // Sign user in method
  void signInUser() async {
   if (_formKey.currentState!.validate()) {
    String username = usernameController.text;
    if (doesUserExist(username, widget.userLists)) {
      // Set the login status to true
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setBool("isLoggedIn", true);

      // Find the user from the userLists based on the username
      User signedInUser = widget.userLists.firstWhere((user) => user.userName == username);

      // Navigate to the book list page and pass the user data
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyBook(user: signedInUser),
        ),
      );
    } else {
      // Show a dialog if user does not exist
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('User not found'),
          content: Text('Please sign up before signing in.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(widget.userLists),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
  void loadUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonuser = preferences.getString("user") ?? '[]';
    print(jsonuser);

    List<dynamic> userData = jsonDecode(jsonuser);
    List<User> users = userData.map((e) => User.fromJson(e)).toList();
    setState(() {
      widget.userLists = users;
    });
  }

  @override
  void initState() {
    loadUser();
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
                'Welcome back you\'ve been missed!',
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
                        validator: (value) {
                          if (value!.isEmpty ) {
                            return 'Please enter a username';
                          } else {
                            return null;
                          }
                        },
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
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: 'Password',
                            hintStyle: TextStyle(color: Colors.grey[500])),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),

              // sign in button
              GestureDetector(
                onTap: () {
                  signInUser();
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
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 50),

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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
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

              // google + apple sign in buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(left: 30),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey[200],
                    ),
                    child: Image.asset(
                      'assets/images/google.png',
                      height: 40,
                    ),
                  ),

                  SizedBox(width: 25),

                  // apple button
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Register now',
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
