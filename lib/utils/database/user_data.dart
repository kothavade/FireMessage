import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserData {
  Future<DocumentSnapshot<Object?>> getUserData({required String uid}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentSnapshot user =
        await firestore.collection('users').doc(uid).get();
    return user;
  }

  Future<void> updateUserData(
      {required String name,
      required String email,
      required String photoUrl,
      required String uid}) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final DocumentReference userRef = firestore.collection('users').doc(uid);
    final DocumentSnapshot user = await userRef.get();
    if (!user.exists) {
      await userRef.set({
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
        'uid': uid,
      });
    } else {
      await userRef.update({
        'name': name,
        'email': email,
        'photoUrl': photoUrl,
      });
    }
  }
}
