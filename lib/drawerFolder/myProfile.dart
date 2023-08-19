import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyProfilePage extends StatefulWidget {
  String? username;
  String? email;
  final String? currentUserId;
  MyProfilePage({this.currentUserId, this.username, this.email, super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

  @override
  Widget build(BuildContext context) {
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
              'Username: ',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Email:',
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
