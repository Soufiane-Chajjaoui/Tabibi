// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable, sort_child_properties_last
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Urgance.dart';
import 'package:project_pfe/auth/Log_in.dart';
import 'package:project_pfe/patient/Profile.dart';
import 'package:project_pfe/patient/search_page.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:http/http.dart' as http;

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
      // extendBody: true,
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
  List<dynamic> _images = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  // test get images from server
  Future _loadImages() async {
    final response = await http.get(
        Uri.parse('http://127.0.0.1:8080/images').replace(host: "192.168.1.3"));
    if (response.statusCode == 200) {
      setState(() {
        _images = jsonDecode(response.body);
      });
    } else {
      // Handle error
    }
  }

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
                    child: IconButton(
                        highlightColor: Colors.transparent,
                        onPressed: () => _callNumber(),
                        icon: Icon(
                          color: Colors.black,
                          Icons.call_outlined,
                          size: 60,
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
          body: Padding(
            padding: EdgeInsetsDirectional.only(top: 2),
            child: FutureBuilder(
                future: Urgance.get_urgance(),
                builder: (context, snapshot) {
                  List<Urgance>? list = snapshot.data as List<Urgance>?;
                  return !snapshot.hasData
                      ? Center(
                          child: Lottie.network(
                          'https://assets4.lottiefiles.com/packages/lf20_x62chJ.json',
                          width: 200,
                          height: 230,
                        ))
                      // : list?.length == 0
                      //     ? Center(child: Text('Data not availabe'))
                          : GridView.count(
                              crossAxisCount: 2,
                              children: List.generate(list!.length, (index) {
                                return IconButton(
                                  highlightColor: Colors.transparent,
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) {
                                      return Log_in();
                                    }));
                                  },
                                  icon: Card(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color:
                                            Color.fromARGB(255, 199, 106, 106),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(12)),
                                            child: Stack(
                                              children: [
                                                Image.memory(
                                                  base64.decode(
                                                      "${list[index].data_Image}"),
                                                  fit: BoxFit.cover,
                                                  width: 200,
                                                  height: 110,
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    icon: Icon(Icons
                                                        .record_voice_over_rounded),
                                                    onPressed: () {},
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(bottom: 4),
                                            child: Text(
                                              "${list[index].libell}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Poppins'),
                                            ),
                                          )
                                        ],
                                      ),
                                      height: 150,
                                      margin: EdgeInsets.all(1),
                                    ),
                                  ),
                                );
                              }),
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
