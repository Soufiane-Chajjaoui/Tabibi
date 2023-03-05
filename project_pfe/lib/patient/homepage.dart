// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable

import 'package:flutter/material.dart';
import 'package:project_pfe/patient/Profile.dart';
import 'package:project_pfe/patient/search_page.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int pageIndex = 0;

  final pages = [
    const accueil(),
    const searchPage(),
    const searchPage(),
    const Profil(),
  ];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      // drawer: Drawer(
      //   width: width / 1.7,
      //   child: Column(
      //     children: [
      //       Center(
      //         child: UserAccountsDrawerHeader(
      //             currentAccountPicture:
      //                 Image.asset("images/doctor_choice.jpg"),
      //             accountName: Text('accountName'),
      //             accountEmail: Text('accountEmail')),
      //       ),
      //     ],
      //   ),
      // ),
      extendBody: true,
      body: pages[pageIndex],
      backgroundColor: Color(0xff99d8d7),
      bottomNavigationBar: buildnavbottom(context),
    );
  }

  Container buildnavbottom(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Color(0xff3279B6), borderRadius: BorderRadius.circular(40)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        IconButton(
          enableFeedback: false,
          onPressed: () {
            setState(() {
              pageIndex = 0;
            });
          },
          icon: pageIndex == 0
              ? const Icon(
                  Icons.other_houses_rounded,
                  color: Colors.white,
                  size: 35,
                )
              : const Icon(
                  Icons.other_houses_outlined,
                  color: Color.fromARGB(255, 181, 172, 172),
                  size: 35,
                ),
        ),
        IconButton(
          enableFeedback: false,
          onPressed: () {
            setState(() {
              pageIndex = 1;
            });
          },
          icon: pageIndex == 1
              ? const Icon(
                  Icons.search_rounded,
                  color: Colors.white,
                  size: 35,
                )
              : const Icon(
                  Icons.search_outlined,
                  color: Color.fromARGB(255, 181, 172, 172),
                  size: 35,
                ),
        ),
        IconButton(
          enableFeedback: false,
          onPressed: () {
            setState(() {
              pageIndex = 2;
            });
          },
          icon: pageIndex == 2
              ? const Icon(
                  Icons.chat,
                  color: Colors.white,
                  size: 35,
                )
              : const Icon(
                  Icons.chat,
                  color: Color.fromARGB(255, 181, 172, 172),
                  size: 35,
                ),
        ),
        IconButton(
          enableFeedback: false,
          onPressed: () {
            setState(() {
              pageIndex = 3;
            });
          },
          icon: pageIndex == 3
              ? const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 35,
                )
              : const Icon(
                  Icons.person_outline,
                  color: Color.fromARGB(255, 181, 172, 172),
                  size: 35,
                ),
        ),
      ]),
    );
  }
}

class accueil extends StatefulWidget {
  const accueil({super.key});

  @override
  State<accueil> createState() => _accueilState();
}

class _accueilState extends State<accueil> {
  
  _callNumber() async {
    const number = '15'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99d8d7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(40),
            //   ),
            // ),
            expandedHeight: 240,
            backgroundColor: Color.fromARGB(255, 241, 66, 66),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    size: 30,
                  ))
            ],
            forceElevated: true,
            elevation: 4,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: Colors.transparent,
                  ),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.lightBlueAccent[200],
                          primary: Color.fromARGB(255, 112, 111, 106)),
                      onPressed: () => _callNumber(),
                      child: Icon(
                        color: Colors.black,
                        Icons.call_outlined,
                        size: 50,
                      )),
                ),
                centerTitle: true,
                title: Text(
                  'Emergency help needed?',
                  style: TextStyle(fontSize: 19),
                )),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
                Expanded(
                    child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  height: 150,
                  margin: EdgeInsets.all(12),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
