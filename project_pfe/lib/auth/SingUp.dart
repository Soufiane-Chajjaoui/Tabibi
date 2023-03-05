// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, non_constant_identifier_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/auth/Log_in.dart';
import 'package:project_pfe/auth/auth_doctor/signUp_two.dart';
import 'package:project_pfe/auth/validations.dart';

class SingUp extends StatefulWidget {
  const SingUp({super.key});

  @override
  State<SingUp> createState() => _SingUpState();
}

class _SingUpState extends State<SingUp> {
  final _formkey = GlobalKey<FormState>();

  static final RegExp nameRegExp = RegExp('[a-zA-Z]');
  // data for doctor passing to page number 2
  late final Map<String, dynamic> data = {};

  var controller_name = TextEditingController();
  var controller_cni = TextEditingController();
  var controller_password = TextEditingController();
  var controller_tele = TextEditingController();

  void passingto2() {
    setState(() {
      data.addAll({
        'name': controller_name.text,
        'cni': controller_cni.text,
        'tele': controller_tele.text,
        'password': controller_password
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic type = ModalRoute.of(context)?.settings.arguments;

    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: double.infinity,
                    height: 175,
                    child: Image.asset(
                      color:
                          Color.fromARGB(255, 139, 128, 128).withOpacity(0.8),
                      colorBlendMode: BlendMode.modulate,
                      'images/scope.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Image.asset(
                      'images/logo_tabibi.png',
                      width: 195,
                      height: 118,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 160),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromARGB(249, 255, 255, 255),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 9),
                          margin: const EdgeInsets.only(top: 20),
                          child: Column(children: [
                            type == 'doctor'
                                ? Text(
                                    'do with us!',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 88, 63, 112),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32),
                                  )
                                : Text(
                                    'Register with us!',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 88, 63, 112),
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 32),
                                  ),
                          ]),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Form(
                                key: _formkey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: TextFormField(
                                        keyboardType: TextInputType.name,
                                        controller: controller_name,
                                        validator: (value) => value!.isEmpty
                                            ? 'Enter Your Name'
                                            : (nameRegExp.hasMatch(value)
                                                ? null
                                                : 'Enter a Valid Name'),
                                        cursorHeight: 30,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.cyan.shade600)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 100, 112, 121))),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            prefixIcon: Icon(
                                                Icons.account_circle_outlined),
                                            prefixIconColor: Color(0xFF034277),
                                            contentPadding: EdgeInsets.all(10),
                                            label: Text(
                                              'Complete Name',
                                              style: TextStyle(
                                                  color: Colors.cyan.shade600,
                                                  fontFamily:
                                                      'PoppinsExtraLight',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: TextFormField(
                                        keyboardType: TextInputType.text,
                                        controller: controller_cni,
                                        cursorHeight: 30,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.cyan.shade600)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.brown)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            prefixIcon:
                                                Icon(Icons.verified_outlined),
                                            prefixIconColor: Color(0xFF034277),
                                            contentPadding: EdgeInsets.all(10),
                                            label: Text(
                                              'CNI',
                                              style: TextStyle(
                                                  color: Colors.cyan.shade600,
                                                  fontFamily:
                                                      'PoppinsExtraLight',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: TextFormField(
                                        validator: (value) =>
                                            validatetele(value!),
                                        keyboardType: TextInputType.phone,
                                        controller: controller_tele,
                                        cursorHeight: 30,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.cyan.shade600)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.brown)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            prefixIcon:
                                                Icon(Icons.numbers_outlined),
                                            prefixIconColor: Color(0xFF034277),
                                            contentPadding: EdgeInsets.all(10),
                                            label: Text(
                                              'Numéro de tele',
                                              style: TextStyle(
                                                  color: Colors.cyan.shade600,
                                                  fontFamily:
                                                      'PoppinsExtraLight',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 4),
                                      child: TextFormField(
                                        validator: (value) =>
                                            validatePassword(value!),
                                        obscureText: true,
                                        controller: controller_password,
                                        cursorHeight: 30,
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.cyan.shade600)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.brown)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: BorderSide(
                                                    color: Colors.red)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide: BorderSide(
                                                        color: Colors.red)),
                                            prefixIcon:
                                                Icon(Icons.password_outlined),
                                            prefixIconColor: Color(0xFF034277),
                                            contentPadding: EdgeInsets.all(10),
                                            label: Text(
                                              'Password',
                                              style: TextStyle(
                                                  color: Colors.cyan.shade600,
                                                  fontFamily:
                                                      'PoppinsExtraLight',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20)))),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xFF3279B6),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(40)),
                                        // background (button) color
                                        // foreground (text) color
                                      ),
                                      onPressed: () async {
                                        if (_formkey.currentState!.validate()) {
                                          if (type == 'doctor') {
                                            passingto2();
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) {
                                                      return SignUp_two();
                                                    },
                                                    settings: RouteSettings(
                                                        arguments: data)));
                                          } else {
                                            await Patient.registre_patient(
                                                controller_cni.text,
                                                controller_tele.text,
                                                controller_name.text,
                                                controller_password.text);
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return Log_in();
                                              },
                                            ));
                                          }
                                        }

                                        // Navigator.of(context).pushNamed
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Sign in",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              child: Row(children: [
                                Expanded(
                                  flex: 1,
                                  child: Divider(
                                    color: Colors.black,
                                    // height: 30,
                                    thickness: 2,
                                  ),
                                ),
                                Expanded(
                                    child: SizedBox(
                                  child: Text(' Or Sign in with'),
                                  width: double.infinity,
                                )),
                                Expanded(
                                  flex: 1,
                                  child: Divider(
                                    color: Colors.black,
                                    // height: 30,
                                    thickness: 2,
                                  ),
                                ),
                              ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset(
                                        'add_Icons/google-plus.png')),
                                IconButton(
                                    onPressed: () {},
                                    icon: Image.asset('add_Icons/apple.png')),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.facebook_outlined,
                                      size: 28,
                                    ))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have account ?',
                                  style: TextStyle(
                                      fontFamily: 'PoppinsExtraLight',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('Log_in');
                                    },
                                    child: Text(
                                      'Log in',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontFamily: 'Poppins'),
                                    ))
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
