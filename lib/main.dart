

import 'package:flutter/material.dart';
import 'package:flutter_application_task1/bookfolder/book_list.dart';
import 'package:flutter_application_task1/loginService/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  

  const MyApp({Key? key}) : super(key: key);

  Future<String> getUserID() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userid = prefs.getString('currentUserId') ?? "";
    return userid;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
 debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true, 
      ),    
         home: FutureBuilder<String>(
        future: getUserID(),
        builder: (context, snapshot) {
          String? currentUserId = snapshot.data;
          if (currentUserId != null && currentUserId.isNotEmpty) {
            return MyBook(CurrentUserID: currentUserId);
          }

        

          else {
            return LoginPage();
          }
        },
      ),
    );
  }
}