import 'package:flutter/material.dart';
import 'package:flutter_application_task1/book_list.dart';
import 'package:flutter_application_task1/sign_in.dart';

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true,
      ),
    
     home:  LoginPage(userLists: userList,),
    );
  }
}
