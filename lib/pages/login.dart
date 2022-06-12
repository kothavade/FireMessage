import 'package:fire_message_v3/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/authentication.dart';

// This page will let the user login with Google into their account.

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
            child: TextButton(
                onPressed: () async {
                  final User? user =
                      await Authentication.signInWithGoogle(context: context);
                  if (user != null) {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: Text(
                  'Login with Google',
                  style: TextStyle(fontSize: 20),
                ))));
  }
}
