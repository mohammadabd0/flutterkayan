import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_task1/loginService/sign_in.dart';
import 'package:flutter_application_task1/restfullApi/getApi.dart';

import 'model/book.dart';
import 'bookfolder/book_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Book book = Book(
    nameBook: "The Hitchhiker's Guide to the Galaxy",
    author: "Douglas Adams",
   
  );

  sendDataToApi(book);
  print(sendDataToApi(book));
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true,
      ),
      home: FirebaseAuth.instance.currentUser != null ? MyBook() : LoginPage(),
    );
  }
}
