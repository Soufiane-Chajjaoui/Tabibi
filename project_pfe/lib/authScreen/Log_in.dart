// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/Agent/screens/homePage.dart';
import 'package:project_pfe/actions/Agent.dart';
import 'package:project_pfe/actions/Doctor.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/authScreen/validations.dart';
import 'package:project_pfe/doctor/homepageDoctor.dart';
import 'package:project_pfe/patient/homepage.dart';

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

  List<String> types = ['Patient', 'Doctor', 'Agent'];

  String? type;

  late bool isSee = true;

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
                                      keyboardType: TextInputType.number,
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
                                          prefixIcon: Icon(Icons.call),
                                          prefixIconColor: Color(0xFF034277),
                                          contentPadding: EdgeInsets.all(10),
                                          label: Text(
                                            'Telephone',
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
                                        horizontal: 15, vertical: 10),
                                    child: TextFormField(
                                      obscureText: isSee ? true : false,
                                      keyboardType: TextInputType.text,
                                      validator: (value) =>
                                          validatePassword(value!),
                                      controller: controller_password,
                                      cursorHeight: 30,
                                      decoration: InputDecoration(
                                          suffixIcon: IconButton(
                                            icon: Icon(isSee
                                                ? Icons.visibility
                                                : Icons.visibility_off),
                                            onPressed: () => setState(() {
                                              isSee = !isSee;
                                            }),
                                          ),
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
                                        horizontal: 15, vertical: 4),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.supervisor_account,
                                          size: 26,
                                        ),
                                        prefixIconColor: Color(0xFF034277),

                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 210, 140, 135),
                                            width: 0,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        isDense: true,
                                        contentPadding: EdgeInsets.only(
                                            left:
                                                0), // Remove horizontal padding
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                      ),
                                      hint: const Text(
                                        'Select Your Gender',
                                        style: TextStyle(
                                          color: Color(0xFF034277),
                                          fontFamily: 'PoppinsExtraLight',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      items: types
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    color: Color(0xFF034277),
                                                    fontFamily:
                                                        'PoppinsExtraLight',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'Please select Your Type.';
                                        }
                                        return null;
                                      },
                                      onChanged: (value) {
                                        type = value;
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
                                              BorderRadius.circular(20),
                                        ),
                                      ),
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
                                                  child: Lottie.network(
                                                      "https://assets1.lottiefiles.com/packages/lf20_gbfwtkzw.json"),
                                                ));
                                        if (type == "Patient") {
                                          // String? result = await SigninChecked(
                                          //     controller_tele.text,
                                          //     controller_password.text,
                                          //     context);
                                          // if (result == 'patient') {
                                          //   Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               Auth()));
                                          // } else if (result == 'doctor') {
                                          //   Navigator.of(context).push(
                                          //       MaterialPageRoute(
                                          //           builder: (context) =>
                                          //               Auth()));
                                          // } else
                                          if (await Patient.login_patient(
                                              controller_tele.text.trim(),
                                              controller_password.text.trim(),
                                              context)) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) => homepage()),
                                              (route) => false,
                                            );
                                          }
                                        } else if (type == 'Agent') {
                                          if (await Agent.LoginAgent(
                                              controller_tele.text,
                                              controller_password.text , context)) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      HomepageAgent()),
                                              (route) => false,
                                            );
                                          }
                                        } else {
                                          if (await Doctor.login_doctor(
                                              controller_tele.text.trim(),
                                              controller_password.text.trim(),
                                              context)) {
                                            Navigator.of(context)
                                                .pushAndRemoveUntil(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      HomepageDoctor()),
                                              (route) => false,
                                            );
                                          }
                                        }
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
