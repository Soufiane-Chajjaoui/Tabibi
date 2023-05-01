// ignore_for_file: unused_import, prefer_const_constructors, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:project_pfe/start_Screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:project_pfe/authScreen/Auth.dart';
import 'package:project_pfe/authScreen/SingUp.dart';
import 'package:project_pfe/Agent/screens/homePage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:project_pfe/authScreen/auth_doctor/signUp_two.dart';

import 'package:project_pfe/choice_type.dart';
import 'package:project_pfe/patient/homepage.dart';

// import 'package:project_pfe/testApi.dart';

import 'package:project_pfe/authScreen/Log_in.dart';
import 'package:project_pfe/patient/search_page.dart';
import 'package:project_pfe/start_Screen.dart';
import 'package:project_pfe/testshowImage.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final prefs = await SharedPreferences.getInstance();
  bool showhome = false;
  if (prefs.getString('patient') != null) {
    showhome = true;
  }
  runApp(MyApp(showhome: showhome));
}

class MyApp extends StatelessWidget {
  final bool showhome;
  const MyApp({
    Key? key,
    required this.showhome,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  void initState() {
    // _checkConnectivity();
  }

  void _checkConnectivity() async {
    var connection = await Connectivity().checkConnectivity();
    print('this is check ' +
        connection
            .name); //this print none I will to use them in login & registre
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "Sing_up": (context) => const SingUp(),
        "Log_in": (context) => const Log_in(),
      },
      theme: ThemeData(
        useMaterial3: true,
      ),
      //home: showhome ?homepage(): choise_type(),
      // we using stream for fetching data but if restart programm it return true and not show indecatorProgress
      // so for eleminet this Problem use method _checkCOnnectivity()
      // home: StreamBuilder<ConnectivityResult>(
      //   stream: Connectivity().onConnectivityChanged,
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     return Scaffold(
      //       body: snapshot.data == ConnectivityResult.none
      //           ? Center(child: CircularProgressIndicator())
      //           : choise_type(),
      //     );
      //   },
      // ),
      // home: showhome ? homepage() :StartPage() ,
      home: Auth(),
      debugShowCheckedModeBanner: false,
    );
  }
}
