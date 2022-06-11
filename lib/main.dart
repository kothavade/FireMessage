import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/home.dart';
import 'pages/init.dart';
import 'pages/login.dart';

// This is the main function. It sends the user to the init page.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FireMessage",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: InitPage(),
    );
  }
}
