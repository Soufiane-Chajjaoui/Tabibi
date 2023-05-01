// ignore_for_file: unused_local_variable, non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, await_only_futures

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/patient/EditProfil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  String? id;
  Patient? patient;

  String name = 'user name';
  getProfil() async {
    final prefs = await SharedPreferences.getInstance();
    id = await prefs.getString('_id');
    print(id);
    patient = await Patient.getProfil(id);
    setState(() {
      name = patient!.complete_name!;
    });
    print(patient!.complete_name);
  }

  @override
  void initState() {
    // TODO: implement initState
    // getProfil();
    super.initState();
    final user = APIs.auth.currentUser;
    print(user);
    setState(() {
      name = "${user?.displayName.toString()}";
    });
  }

  // widgets
  Padding listechoixe(IconData? icon, String TitleList, bool islink) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: Color(0xff3279B6),
                size: 28,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  '${TitleList}',
                  style: TextStyle(fontFamily: 'PoppinsBold'),
                ),
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: islink ? Color(0xff3279B6) : Colors.transparent,
          )
        ],
      ),
    );
  }

  Padding cardstatus(BuildContext context, String? Height, String? taille) {
    var size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 100,
        width: size / 4,
        decoration: const BoxDecoration(
          color: Color(0xff3279B6),
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(78, 0, 0, 0),
              offset: const Offset(2, 0),
              blurRadius: 3,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                Height!,
                style: const TextStyle(
                  fontFamily: 'Poppins_Reguler',
                  fontSize: 12,
                  color: Color.fromARGB(137, 255, 255, 255),
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  taille!,
                  style: const TextStyle(
                    fontFamily: 'Poppins_Reguler',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(205, 255, 255, 255),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Padding blood(BuildContext context, String? Height, String? taille) {
    var size = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: 50,
        width: size / 4,
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(78, 0, 0, 0),
                offset: const Offset(2, 0),
                blurRadius: 3,
                spreadRadius: 1,
              ),
            ],
            color: Color(0xff3279B6),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                Height!,
                style: const TextStyle(
                  fontFamily: 'Poppins_Reguler',
                  fontSize: 12,
                  color: Color.fromARGB(137, 255, 255, 255),
                ),
              ),
            ),
            Container(
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.only(right: 8),
                child: Text(
                  taille!,
                  style: const TextStyle(
                    fontFamily: 'Poppins_Reguler',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(205, 255, 255, 255),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(208, 227, 245, 245),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
            width: double.infinity,
            height: 230,
            decoration: const BoxDecoration(
                color: Color(0xffA0B0E2),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      blurStyle: BlurStyle.normal,
                      color: Colors.black54,
                      offset: Offset(0, 1.3),
                      blurRadius: 6,
                      spreadRadius: 1)
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // OutlinedButton(
                      //     style: OutlinedButton.styleFrom(
                      //         foregroundColor: Colors.black,
                      //         backgroundColor: Colors.white54,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(70))),
                      //     onPressed: () {},
                      //     child: Icon(Icons.arrow_back_ios_new)),

                      IconButton(
                          style: IconButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(179, 102, 80, 148),
                              foregroundColor:
                                  Color.fromARGB(184, 246, 229, 229)),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return EditProfil();
                              },
                            ));
                          },
                          icon: Icon(Icons.edit)),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: Image.asset(
                        "images/pngwing.png",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Text(
                      "${name}",
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Male '),
                        Icon(
                          Icons.circle,
                          size: 9,
                        ),
                        Text(' 19 y.o')
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                cardstatus(context, 'Height', "187 cm"),
                cardstatus(context, 'Weight', "78 kg"),
                Column(
                  children: [
                    blood(context, 'Blood', "O+"),
                    blood(context, 'Blood Cells', "1260 g/dl"),
                  ],
                )
              ],
            ),
          ),
          Column(
            children: [
              listechoixe(
                  Icons.gps_fixed_rounded, 'Automatic GPS Sharing', true),
              listechoixe(
                  Icons.account_circle_rounded, 'Contact Details', true),
              listechoixe(Icons.history_rounded, 'Emergency Historic', true),
              listechoixe(Icons.help_outlined, 'Helps & Support', false),
              IconButton(
                  onPressed: () {
                    APIs.auth.signOut();
                  },
                  icon: listechoixe(Icons.logout_rounded, 'Logout', false))
            ],
          )
        ],
      ),
    );
  }
}
