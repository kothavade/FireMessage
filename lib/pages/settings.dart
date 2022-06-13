import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late User _user;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _user = widget._user;
  }

  // getPhoto() {
  //   firestore.collection('users').doc(_user.uid).get().then((doc) {
  //     return doc.data()!['photoUrl'];
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //     getPhoto(),
              //   ),
              //   radius: 50,
              // ),
              Text('User: ${_user.displayName}'),
              Text('Email: ${_user.email}'),
              Text('ID: ${_user.uid}'),
            ],
          ),
        ),
      ),
    );
  }
}
