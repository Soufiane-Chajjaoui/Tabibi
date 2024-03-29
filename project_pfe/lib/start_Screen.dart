import 'package:flutter/material.dart';
import 'package:project_pfe/choice_type.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(children: [
          Image.asset(
            color: Color.fromARGB(255, 139, 128, 128).withOpacity(0.8),
            colorBlendMode: BlendMode.modulate,
            alignment: Alignment.topLeft,
            'images/doctors_start_page.jpeg',
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  'images/logo_tabibi.png',
                ),
                Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)),
                          backgroundColor: Color.fromARGB(133, 174, 157, 157),
                          // background (button) color
                          // foreground (text) color
                          foregroundColor: Color.fromARGB(255, 189, 206, 219)),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const choise_type()));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 264,
                        height: 56,
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.transparent,
                    //     side: BorderSide(
                    //         color: Color.fromARGB(255, 208, 199, 197),
                    //         width: 1),
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
                    //     height: 56,
                    //     child: Text(
                    //       "Ceate account",
                    //       style: TextStyle(
                    //           fontSize: 30,
                    //           fontFamily: 'Poppins',
                    //           color: Color.fromARGB(213, 172, 176, 173)),
                    //     ),
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
