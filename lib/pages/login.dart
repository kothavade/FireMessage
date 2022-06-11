import 'package:flutter/material.dart';

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
        body: const Center(
            child: TextButton(
                onPressed: onPressed,
                child: Text(
                  'Login with Google',
                  style: TextStyle(fontSize: 20),
                ))));
  }
}
