import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/API/registre.dart';
import 'package:project_pfe/actions/Doctor.dart';
import 'package:project_pfe/authScreen/Auth.dart';
import 'package:project_pfe/authScreen/Log_in.dart';
import 'package:project_pfe/authScreen/Widget/Widget.dart';
import 'package:project_pfe/authScreen/validations.dart';

import '../../Agent/screens/homePage.dart';

class SignUp_two extends StatefulWidget {
  const SignUp_two({super.key});

  @override
  State<SignUp_two> createState() => _SignUp_twoState();
}

class _SignUp_twoState extends State<SignUp_two> {
  final _formkey = GlobalKey<FormState>();
  var controller_email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    dynamic fromPageOne = ModalRoute.of(context)?.settings.arguments;

    // print(!fromPageOne['data']);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                        padding: const EdgeInsets.only(top: 11, bottom: 14),
                        child: Column(children: [
                          Text(
                            fromPageOne['name'] +
                                ' Choisissez votre Speciality',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF034277),
                                fontFamily: 'Poppins_Reguler',
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
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
                                        vertical: 10, horizontal: 15),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color: Colors.red,
                                                width: 1.5,
                                                style: BorderStyle.solid)),
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: EdgeInsets.zero,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        //Add more decoration as you want here
                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                      ),
                                      hint: const Text(
                                        'Select Your Speciality',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      items: Doctor.speciality
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select Speciality.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        // print(value is String);
                                        // print(value.runtimeType);
                                        fromPageOne
                                            .addAll({'speciality': value});
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        height: 60,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black45,
                                        ),
                                        iconSize: 30,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: Icon(
                                                Icons.arrow_back_ios_rounded),
                                            label: Text('Back',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily:
                                                        'Poppins_Reguler'))),
                                        TextButton(
                                          onPressed: () async {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ));
                                              final result =
                                                  regiterUserwithName(
                                                fromPageOne['email'],
                                                fromPageOne['password'],
                                                fromPageOne['name'],
                                                'doctor',
                                                fromPageOne['speciality'],
                                              );
                                              if (result != 'success') {
                                                snackbar(
                                                  resultMessage:
                                                      result.toString(),
                                                );
                                              }else 
                                              {Navigator.of(context)
                                                  .pushReplacement(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Auth()));}
                                            }
                                          },
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins_Reguler'),
                                          ),
                                        ),
                                      ],
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
                                  onPressed: () {},
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
