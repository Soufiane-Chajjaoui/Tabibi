import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_pfe/API/api.dart';

Future<String> regiterUserwithName(
    email, password, displayName, role, speciality) async {
  try {
    final UserCreate = await APIs.auth
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.'; // passwor d3iff
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
  } catch (e) {
    return e.toString();
  }
  final Usercurrent = APIs.auth.currentUser;
  Usercurrent?.updateDisplayName(displayName);

  final CollectionReference _Users = APIs.firestore.collection('Users');
  switch (speciality) {
    case '':
      await _Users.add({'role': role, 'idUser': Usercurrent?.uid});

      break;
    default:
      await _Users.add(
          {'role': role, 'idUser': Usercurrent?.uid, 'speciality': speciality});
  }
  if (APIs.auth.currentUser != null)
    return 'true';
  else
    return 'wornig';
}

AnonymoseUser() async {
  await APIs.auth.signInAnonymously();
}
