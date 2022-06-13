import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  ChatPage(
      {Key? key,
      required QueryDocumentSnapshot<Object> user,
      required QueryDocumentSnapshot<Object> chatUser})
      : _user = user,
        _chatUser = chatUser,
        super(key: key);
  final QueryDocumentSnapshot<Object> _user;
  final QueryDocumentSnapshot<Object> _chatUser;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final textController = TextEditingController();

  String formatTimestamp(Timestamp timestamp) {
    final String formatted =
        DateFormat.yMd().add_jm().format(timestamp.toDate());
    return formatted;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._chatUser['name']),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chats')
                    .doc(widget._user.id)
                    .collection('chats')
                    .doc(widget._chatUser.id)
                    .collection('messages')
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  }
                  final List<QueryDocumentSnapshot<Object?>>? documents =
                      snapshot.data?.docs;
                  if (documents != null && documents.isNotEmpty) {
                    return ListView.builder(
                      reverse: true,
                      itemCount: documents.length,
                      itemBuilder: (BuildContext context, int index) {
                        final QueryDocumentSnapshot<Object?> document =
                            documents[index];
                        return ListTile(
                          leading: document['userId'] == widget._chatUser.id
                              ? CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget._chatUser['photoUrl']),
                                )
                              : null,
                          trailing: document['userId'] == widget._user.id
                              ? CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget._user['photoUrl']),
                                )
                              : null,
                          title: Text(
                            document['text'],
                            textAlign: document['userId'] == widget._user.id
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                          subtitle: Text(
                            formatTimestamp(document['createdAt']),
                            textAlign: document['userId'] == widget._user.id
                                ? TextAlign.right
                                : TextAlign.left,
                          ),
                          // tileColor: document['userId'] == widget._user.uid
                          //     ? Colors.blue
                          //     : Colors.grey,
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text('No messages found.'),
                    );
                  }
                },
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: InputDecoration(
                        hintText: 'Enter a message',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              firestore
                                  .collection('chats')
                                  .doc(widget._user.id)
                                  .collection('chats')
                                  .doc(widget._chatUser.id)
                                  .collection('messages')
                                  .add({
                                'text': textController.text,
                                'createdAt': Timestamp.now(),
                                'userId': widget._user.id,
                              });
                              firestore
                                  .collection('chats')
                                  .doc(widget._chatUser.id)
                                  .collection('chats')
                                  .doc(widget._user.id)
                                  .collection('messages')
                                  .add({
                                'text': textController.text,
                                'createdAt': Timestamp.now(),
                                'userId': widget._user.id,
                              });
                              textController.clear();
                            })),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
