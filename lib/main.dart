import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_task1/book_list.dart';
import 'package:flutter_application_task1/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/user.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<User> userList = [];
bool isLoggedIn = false; // Add this variable to keep track of the login status
User? currentUser;

  @override
  void initState() {
    checkLoginStatus();
    loadUser(); // Check the login status when the app starts
    super.initState();
  }
    void loadUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonuser = preferences.getString("user") ?? '[]';
    List<dynamic> userData = jsonDecode(jsonuser);
    List<User> users = userData.map((e) => User.fromJson(e)).toList();
    setState(() {
      userList = users; 
    });
    
  }

void checkLoginStatus() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  bool isLoggedIn = preferences.getBool("isLoggedIn") ?? false;

  setState(() {
    this.isLoggedIn = isLoggedIn;
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true,
      ),
    
    home: isLoggedIn ? MyBook() : LoginPage(userLists: userList),
    );
  }
}
