import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:project_pfe/API/api.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/Agent/screens/homePage.dart';
import 'package:project_pfe/patient/homepage.dart';

Future<String?> SigninChecked(email, password, BuildContext context) async {
  try {
    await APIs.auth
        .signInWithEmailAndPassword(email: email, password: password);

    final Usercurrent = await APIs.auth.currentUser;

    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('Users');

    QuerySnapshot querySnapshot = await usersCollection
        .where('idUser', isEqualTo: Usercurrent?.uid)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
      final userChecked = documentSnapshot.data() as Map<String, dynamic>;
      switch (userChecked['role']) {
        case 'patient':
          return 'patient';
        case 'doctor':
          return 'doctor';
        default:
          return 'patient';
      }
    } else {
      return 'User not found';
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else {
      return 'Sign in failed: ${e.message}.';
    }
  } catch (e) {
    return "${e}";
  }
}

signinWithGoogle() async {}

signinAnonymose() async {
  await APIs.auth.signInAnonymously();
}

SignOut() async {
  await APIs.auth.signOut();
}
