// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:project_pfe/Agent/screens/homePage.dart';
// import 'package:project_pfe/authScreen/Log_in.dart';
// import 'package:project_pfe/authScreen/SingUp.dart';
// import 'package:project_pfe/patient/homepage.dart';
// import 'package:project_pfe/API/api.dart';
// import 'package:project_pfe/start_Screen.dart';

// class Auth extends StatefulWidget {
//   const Auth({super.key});

//   @override
//   State<Auth> createState() => _AuthState();
// }

// class _AuthState extends State<Auth> {
//   bool isDoctor = false;

//   Future check() async {
//     final CollectionReference usersCollection =
//         FirebaseFirestore.instance.collection('Users');

//     QuerySnapshot querySnapshot = await usersCollection
//         .where('idUser', isEqualTo: '${APIs.auth.currentUser?.uid}')
//         .get();

//     if (querySnapshot.docs.isNotEmpty) {
//       DocumentSnapshot documentSnapshot = await querySnapshot.docs.first;
//       final userauth = documentSnapshot.data() as Map<String, dynamic>;
//       print(userauth["role"]);
//       if (userauth["role"] == 'doctor') {
//         setState(()  {
//          isDoctor = true;
//         });
//       }
//     } else {
//       print('User not found');
//     }
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     check();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: APIs.auth.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           if (isDoctor) {
//             return HomepageAgent();
//           } else {
//             return homepage();
//           }
//         } else {
//           return const StartPage();
//         }
//       },
//     );
//   }
// }
