import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire_message_v3/pages/settings.dart';
import 'package:fire_message_v3/utils/auth/google_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'chat.dart';
import 'init.dart';

// This page will show the user their messages.
class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  User user = GoogleAuth().currentUser();
  late QueryDocumentSnapshot<Object> me;

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
                    GoogleAuth().signOut(context: context);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => InitPage()),
                    );
                    break;
                  case 'settings':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SettingsPage(
                          user: GoogleAuth().currentUser(),
                        ),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 'signout',
                    child: Row(children: const [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.exit_to_app),
                      ),
                      Text('Sign Out'),
                    ]),
                  ),
                  PopupMenuItem(
                      value: 'settings',
                      child: Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.settings),
                          ),
                          Text('Settings'),
                        ],
                      ))
                ];
              },
            )
          ],
        ),
        body: Container(
          child: getUsers(),
        ));
  }

  getUsers() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return SnackBar(
            content: Text('Error: ${snapshot.error}'),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final QueryDocumentSnapshot<Object>? document =
                  snapshot.data?.docs[index] as QueryDocumentSnapshot<Object>?;
              if (document != null && snapshot.data?.docs.length != 1) {
                if (document.id != user.uid) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(document['photoUrl']),
                    ),
                    title: Text(document['name']),
                    subtitle: Text(document['email']),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            user: me,
                            chatUser: document,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  me = document;
                  return Container();
                }
              } else {
                return const Center(
                  child: Text('No users found'),
                );
              }
            },
          );
        }
      },
    );
  }
}
