// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/actions/Doctor.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/authScreen/Auth.dart';
import 'package:project_pfe/authScreen/Widget/Widget.dart';
import 'package:project_pfe/authScreen/validations.dart';
import 'package:project_pfe/patient/homepage.dart';

import '../API/signin.dart';
import '../Agent/screens/homePage.dart';
// import 'package:project_pfe/Person.dart';

// ignore: camel_case_types
class Log_in extends StatefulWidget {
  const Log_in({super.key});

  @override
  State<Log_in> createState() => _Log_inState();
}

class _Log_inState extends State<Log_in> {
  final _formKey = GlobalKey<FormState>();

  var controller_password = TextEditingController();
  var controller_tele = TextEditingController();

  @override
  Widget build(BuildContext context) {
    dynamic email = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 175,
                child: Image.asset(
                  color: Color.fromARGB(255, 139, 128, 128).withOpacity(0.8),
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
              Expanded(
                child: Container(
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
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: Column(children: [
                          Text(
                            'Walcome to Back !',
                            style: TextStyle(
                                color: Color(0xFF034277),
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
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: TextFormField(
                                      //   keyboardType: email['person'] == 'doctor'
                                      // ? TextInputType.emailAddress
                                      // : TextInputType.phone,
                                      // validator: (value) =>
                                      //     email['person'] == 'doctor'
                                      //         ? validateEmail(value!)
                                      //         : validatetele(value!),
                                      controller: controller_tele,
                                      keyboardType: TextInputType.emailAddress,
                                      cursorHeight: 30,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF034277))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                          prefixIcon: Icon(
                                              Icons.alternate_email_outlined),
                                          prefixIconColor: Color(0xFF034277),
                                          contentPadding: EdgeInsets.all(10),
                                          label: Text(
                                            'Email',
                                            style: TextStyle(
                                                color: Color(0xFF034277),
                                                fontFamily: 'PoppinsExtraLight',
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
                                        horizontal: 15, vertical: 5),
                                    child: TextFormField(
                                      obscureText: true,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      validator: (value) =>
                                          validatePassword(value!),
                                      controller: controller_password,
                                      cursorHeight: 30,
                                      decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Color(0xFF034277))),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Colors.blue)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: BorderSide(
                                                      color: Colors.red)),
                                          prefixIcon: Icon(Icons.password),
                                          prefixIconColor: Color(0xFF034277),
                                          contentPadding: EdgeInsets.all(10),
                                          label: Text(
                                            'Password',
                                            style: TextStyle(
                                                color: Color(0xFF034277),
                                                fontFamily: 'PoppinsExtraLight',
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
                                        horizontal: 15),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                'Forget Password?',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black,
                                                    fontFamily: 'Poppins'),
                                              )),
                                        ]),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF3279B6),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (context) => Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ));
                                        String? result = await SigninChecked(
                                            controller_tele.text,
                                            controller_password.text,
                                            context);
                                        if (result == 'patient') {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Auth()));
                                        } else if (result == 'doctor') {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Auth()));
                                        } else
                                          snackbar(resultMessage: result);
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "Log in",
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
                                  child: Container(
                                      child: Text('Or Sign in with'))),
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
                                  onPressed: () async {
                                    final user = await APIs.auth.currentUser;
                                    await user?.updateDisplayName('chajjaoui');
                                    // print(user?.di);
                                  },
                                  icon:
                                      Image.asset('add_Icons/google-plus.png')),
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
                                        .pushReplacementNamed('Sing_up');
                                  },
                                  child: Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontFamily: 'Poppins'),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 40,
                            width: double.infinity,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
