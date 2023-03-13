// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:project_pfe/auth/Log_in.dart';
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
      floatingActionButton: buildnavbottom(context),
    );
  }

  Container buildnavbottom(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: 50,
      margin: EdgeInsets.only(left: width / 10.5),
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
      backgroundColor: Color.fromARGB(208, 227, 245, 245),
      body: SafeArea(
        child: NestedScrollView(
          //floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.vertical(
              //     bottom: Radius.circular(40),
              //   ),
              // ),

              expandedHeight: 200,
              backgroundColor: Color.fromARGB(255, 236, 193, 193),
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
              pinned: true,
              floating: false,
              flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: Container(
                    decoration: BoxDecoration(
                      // borderRadius: BorderRadius.only(
                      //     bottomLeft: Radius.circular(20),
                      //     bottomRight: Radius.circular(20)),
                      color: Colors.transparent,
                    ),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            onPrimary: Color.fromARGB(255, 64, 255, 137),
                            primary: Color.fromARGB(185, 205, 204, 202)),
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
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins'),
                  )),
            ),
          ],
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(12, (index) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return Log_in();
                  }));
                },
                icon: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 199, 106, 106),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'images/logo_tabibi.png',
                              alignment: Alignment.topCenter,
                            ),
                            Text(
                              'Lah yshafina',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            )
                          ],
                        ),
                      )),
                  height: 150,
                  margin: EdgeInsets.all(1),
                ),
              );
            }),
          ),
          // body: ListView.builder(
          //     itemCount: 40,
          //     itemBuilder: (context, i) {
          //       return Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //         children: [
          //           Expanded(
          //               child: Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: Color.fromARGB(255, 199, 106, 106),
          //             ),
          //             height: 150,
          //             margin: EdgeInsets.all(12),
          //           )),
          //           Expanded(
          //               child: Container(
          //             decoration: BoxDecoration(
          //               borderRadius: BorderRadius.circular(12),
          //               color: Color.fromARGB(255, 199, 106, 106),
          //             ),
          //             height: 150,
          //             margin: EdgeInsets.all(12),
          //           )),
          //         ],
          //       );
          //     }),
        ),
      ),
    );
  }
}
