import 'package:flutter/material.dart';
// import 'package:project_pfe/start_Screen.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'package:project_pfe/auth/SingUp.dart';
import 'package:project_pfe/choice_type.dart';
import 'package:project_pfe/patient/homepage.dart';

// import 'package:project_pfe/testApi.dart';

import 'package:project_pfe/auth/Log_in.dart';
import 'package:project_pfe/patient/search_page.dart';
import 'package:project_pfe/start_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showhome = prefs.getBool('showhome') ?? false;
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
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "Sing_up": (context) => const SingUp(),
        "Log_in": (context) => const Log_in(),
      },
      theme: ThemeData(),
      //home: showhome ?homepage(): choise_type(),
      home: const homepage(),
      //home: const  SingUp(),
      debugShowCheckedModeBanner: false,
    );
  }
}
