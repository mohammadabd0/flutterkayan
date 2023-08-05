import 'package:flutter/material.dart';
import 'package:flutter_application_task1/model/user.dart';
import 'package:flutter_application_task1/myLibrary.dart';
import 'package:flutter_application_task1/settengs.dart';
import 'package:flutter_application_task1/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'MyProfile.dart';

 
class MyDrawer extends StatelessWidget {
  void logoutUser(BuildContext context) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setBool('isLoggedIn', false);
  preferences.remove('userId');
  preferences.remove('username');
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => LoginPage(userLists: [],)),
  );
}

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: Color.fromARGB(255, 58, 131, 183),
      elevation: 2,
      child: ListView(
        children: [
          ListTile(
            title: Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyProfilePage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('My Library'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyLibraryPage(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MySettingsPage(),
                ),
              );
            },
          ),
           Divider(height: 10), 
           ListTile(
            title: Text('Logout'),
            onTap: () {
                  logoutUser(context);

            },
          ),
        ],
      ),
    );
  }
}