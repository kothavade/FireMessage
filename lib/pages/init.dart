import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'home.dart';
import 'login.dart';
// This routes the user to the home or login page depending on
// if they are logged in or not.

class InitPage extends StatefulWidget {
  InitPage({Key? key}) : super(key: key);

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return _auth.currentUser != null ? HomePage() : LoginPage();
  }
}
