import 'package:fire_message_v3/utils/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'init.dart';

// This page will show the user their messages.
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Messages'),
          actions: <Widget>[
            PopupMenuButton(
              onSelected: (selected) async {
                switch (selected) {
                  case 'signout':
                    Authentication.signOut(context: context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => InitPage()),
                    );
                    break;
                  case 'settings':
                    // TODO: Implement settings. Link to user_info.dart
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  const PopupMenuItem(
                    value: 'signout',
                    child: Text('Sign Out'),
                  ),
                  const PopupMenuItem(
                    value: 'settings',
                    child: Text('Settings'),
                  )
                ];
              },
            )
          ],
        ),
        body: const Center(
          child: Text('Messages'),
        ));
  }
}
