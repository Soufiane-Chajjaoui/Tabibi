// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, non_constant_identifier_names
import 'package:project_pfe/auth/SingUp.dart';
import 'package:project_pfe/patient/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class choise_type extends StatefulWidget {
  const choise_type({super.key});

  @override
  State<choise_type> createState() => _choise_typeState();
}

class _choise_typeState extends State<choise_type> {
  static String? selected;
  final Future<SharedPreferences> choice_ = SharedPreferences.getInstance();

  Widget CustomRadio(String image, String index) => OutlinedButton(
        style: OutlinedButton.styleFrom(
          shadowColor: Color.fromARGB(255, 102, 131, 204),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: selected != index ? 2 : 12,
          padding: EdgeInsets.all(1),
          side: BorderSide(
            color: selected != index
                ? Color.fromARGB(255, 171, 175, 182)
                : Color.fromARGB(189, 69, 122, 214),
            width: 2,
          ),
        ),
        onPressed: () async {
          setState(() {
            selected = index;
          });
        },
        child: Stack(clipBehavior: Clip.none, children: [
          Container(
            height: 200,
            width: 120,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitHeight,
                    image: AssetImage(
                      image,
                    )),
                borderRadius: BorderRadius.circular(10)),
          ),
          Positioned(
              top: 10,
              left: 5,
              child: selected == index
                  ? Icon(
                      Icons.check_circle,
                      color: Color.fromARGB(189, 69, 122, 214),
                    )
                  : Icon(
                      Icons.circle_outlined,
                      color: Color.fromARGB(255, 171, 175, 182),
                    )),
          Positioned(
              top: 160,
              left: 25,
              child: selected != index
                  ? Text(
                      "",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    )
                  : Text(
                      index,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Poppins'),
                    )),
        ]),
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background_Image.jpg'),
                fit: BoxFit.fitHeight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: EdgeInsets.only(left: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                'Log in to your\naccount !',
                style: TextStyle(fontSize: 20, fontFamily: 'Poppins'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomRadio("images/doctor_choice.jpg", "doctor"),
                CustomRadio("images/patient_choice.jpg", "patient")
              ],
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      backgroundColor:
                          Color(0xff3279B6), // background (button) color
                      // foreground (text) color
                    ),
                    onPressed: () async {
                      if (selected != null) {
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setBool('showhome', true);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                              return SingUp();
                            },
                            settings: RouteSettings(arguments: selected)));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.cyan[300],
                            content: const Text(
                              'Please select Your Status',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 88, 63, 112),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: 'Poppins'),
                            ),
                            duration: const Duration(milliseconds: 3000),
                            width: 280.0, // Width of the SnackBar.
                            padding: const EdgeInsets.all(
                                15 // Inner padding for SnackBar content.
                                ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 264,
                      height: 50,
                      child: Text(
                        "Next",
                        style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Color(0xff0E3E67),
                  //     side: BorderSide(
                  //         color: Color.fromARGB(255, 208, 199, 197), width: 1),
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(40)),
                  //     // background (button) color
                  //     // foreground (text) color
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(context).pushReplacementNamed('Sing_up');
                  //   },
                  //   child: Container(
                  //     alignment: Alignment.center,
                  //     width: 264,
                  //     height: 50,
                  //     child: Text(
                  //       "Previous",
                  //       style: TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
