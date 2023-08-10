import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  String? username;
  String? email;
   MyProfilePage({ this.username,this.email,super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          
        ],
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "My Profile ",
          style: TextStyle(color: Colors.white),
          
        ),
      ),
      body: Column(children: [
        Text('Username: ${widget.username ?? ''}'),
        Text('Username: ${widget.email ?? ''}'),
      ],),
    );
  }
}