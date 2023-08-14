import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class MyProfilePage extends StatefulWidget {
  String? username;
  String? email;
  final String? CurrentUserID;
  MyProfilePage({this.CurrentUserID, this.username, this.email, super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  List<User>? userList;
  @override
  void initState() {
    //loadUserData();
    super.initState();
  }

  void loadUserData() async {
    if (widget.CurrentUserID != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String jsonUsers = prefs.getString('user') ?? '[]';
      List<dynamic> userData = jsonDecode(jsonUsers);
      userList = userData.map((user) => User.fromJson(user)).toList();

      User? currentUser =
          userList!.firstWhere((user) => user.userId == widget.CurrentUserID);

      if (currentUser != null) {
        setState(() {
          widget.username = currentUser.userName;
          widget.email = currentUser.email;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    loadUserData();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Profile Page',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 80.0),
            const CircleAvatar(
              maxRadius: 100.0,
              backgroundImage: AssetImage('assets/images/mohammad.jpg'),
            ),
            const SizedBox(height: 20.0),
            const Divider(
              color: Colors.black,
              thickness: 3,
              indent: 90,
              endIndent: 90,
            ),
            const SizedBox(height: 50.0),
            Text(
              'Username: ${widget.username}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Email: ${widget.email}',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
