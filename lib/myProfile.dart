import 'package:flutter/material.dart';
import 'model/user.dart';

class MyProfilePage extends StatefulWidget {

  MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      
    );
  }
}
