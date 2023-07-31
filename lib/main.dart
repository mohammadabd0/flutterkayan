import 'package:flutter/material.dart';
import 'package:flutter_application_task1/book_list.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 58, 131, 183)),
        useMaterial3: true,
      ),
    
     home:  MyBook(),
    );
  }
}
