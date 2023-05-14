import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/Agent/screens/homePage.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../authScreen/Auth.dart';

Future<dynamic> regiterUserwithName(
    email, password, displayName, role, speciality, context) async {
  String? error = '';

  try {
    final UserCreate = await APIs.auth
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      error = 'The password provided is too weak.'; // passwor d3iff
    } else if (e.code == 'email-already-in-use') {
      error = 'The account already exists for that email.';
    }
  } catch (e) {
    return e.toString();
  }

  final Usercurrent = APIs.auth.currentUser;
  await Usercurrent?.updateDisplayName(displayName);

  final CollectionReference _Users = APIs.firestore.collection('Users');
  switch (speciality) {
    case '':
      await _Users.add({'role': role, 'idUser': Usercurrent?.uid});

      break;
    default:
      await _Users.add(
          {'role': role, 'idUser': Usercurrent?.uid, 'speciality': speciality});
      break;
  }
  if (error != '') {
    return Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromARGB(255, 219, 101, 92),
        textColor: Colors.white,
        fontSize: 12.0);
  } else
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => Auth()));
}

AnonymoseUser() async {
  await APIs.auth.signInAnonymously();
}
