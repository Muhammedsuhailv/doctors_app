import 'package:flutter/material.dart';
import 'package:kayla_soft/views/edit_doctor.dart';
import 'package:kayla_soft/views/bottom_navbar/bottom_navbar.dart';
import 'package:kayla_soft/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage()
    );
  }
}
