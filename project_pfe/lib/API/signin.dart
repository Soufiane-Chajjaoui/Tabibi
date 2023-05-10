import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

Future<UserCredential?> signinWithGoogle() async {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

//   try {
//     // Trigger the authentication flow.
//     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

//     if (googleUser == null) {
//       // User cancelled the sign-in flow.
//       return null;
//     } else {
//       // Obtain the auth details from the request.
//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;

//       // Create a new credential.
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       // Sign in with the credential.
//       try {
//         final UserCredential authResult =
//             await _auth.signInWithCredential(credential);
//         final User? user = authResult.user;
//         return user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // Handle account linking errors.
//           // ...
//         } else if (e.code == 'invalid-credential') {
//           // Handle invalid credential errors.
//           // ...
//         }
//       } catch (e) {
//         // Handle other errors.
//         // ...
//       }
//     }
//   } on PlatformException catch (e) {
//     print('Platform Exception: ${e.code} - ${e.message}');
//   } catch (e) {
//     print('Sign-in failed with error: $e');
//   }
// }
  try {
    //trigger authentification flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain the auth details from the request

    final GoogleSignInAuthentication? googoleAuth =
        await googleUser?.authentication;

    // create new credential
    final OAuthCredential credential = await GoogleAuthProvider.credential(
        accessToken: googoleAuth!.accessToken, idToken: googoleAuth.idToken);
    return await APIs.auth.signInWithCredential(credential);
  } on FirebaseAuthException catch (e) {
    // Code to handle a specific exception from FirebaseAuth
    if (e.code == 'user-not-found') {
      print('User not found');
    } else if (e.code == 'wrong-password') {
      print('Wrong password');
    }
  } catch (e) {
    // Code to handle any other exception
    print('An unknown error occurred: $e');
  }
  return null;
}



signinAnonymose() async {
  await APIs.auth.signInAnonymously();
}

SignOut() async {
  await APIs.auth.signOut();
}
