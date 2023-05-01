// ignore_for_file: prefer_const_constructors, camel_case_types, unused_local_variable, sort_child_properties_last, curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Urgance.dart';
import 'package:project_pfe/authScreen/Log_in.dart';
import 'package:project_pfe/patient/Profile.dart';
import 'package:project_pfe/patient/Sous_urgance.dart';
import 'package:project_pfe/patient/search_page.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:badges/badges.dart' as badges;

// ignore: camel_case_types
class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  void getID(BuildContext context) async {
    // Patient patient;
    final _prefs = await SharedPreferences.getInstance();
    dynamic person = await ModalRoute.of(context)?.settings.arguments;
    // patient = Patient(cni: cni, tele: tele, complete_name: complete_name, password: password)
    // print(person['patient']["_id"]);
    if (person != null) {
      if (await _prefs.getString('_id') == null) {
        await _prefs.setString("_id", person['patient']["_id"]);
      } else
        print(await _prefs.getString('_id'));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    // getID(context);
    super.initState();
  }

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
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    Patient.getUrgance();
  }

  // test get images from server
  // Future _loadImages() async {
  //   final response = await http.get(
  //       Uri.parse('http://127.0.0.1:8080/images').replace(host: "192.168.1.3"));
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _images = jsonDecode(response.body);
  //     });
  //   } else {
  //     // Handle error
  //   }
  // }
  speak(String libell) async {
    await flutterTts.setLanguage("en-AR"); //ar-MO //fr-MA
    await flutterTts.setPitch(1);
    await flutterTts.speak(libell);
  }

  _callNumber() async {
    const number = '15'; //set the number here
    bool? res = await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(208, 227, 245, 245),
        // appBar: AppBar(
        //   bottomOpacity: 0.5,
        //   title: Text('Urgence'),
        //   centerTitle: true,
        //   actions: [
        //     IconButton(onPressed: () => print(3), icon: Icon(Icons.notifications))
        //   ],
        // ),
        // appBar: StreamBuilder<Object>(
        //   stream: null,
        //   builder: (context, snapshot) {
        //     return AppBar(
        //       title: Text(
        //         'Emergency',
        //         style: TextStyle(fontFamily: 'Poppins_SemiBoldItalic'),
        //       ),
        //       centerTitle: true,
        //       backgroundColor: Color.fromARGB(255, 236, 193, 193),
        //       actions: [
        //         badges.Badge(
        //           position: badges.BadgePosition.topEnd(top: 10, end: 10),
        //           child: IconButton(
        //             icon: Icon(Icons.notifications_none_rounded),
        //             onPressed: () {},
        //           ),
        //         )
        //       ],
        //     );
        //   }
        // ),
        body: NestedScrollView(
          //floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              expandedHeight: 200,
              backgroundColor: Color.fromARGB(255, 236, 193, 193),
              centerTitle: true,
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                              flex: 3,
                              child: Text(
                                'Emergency Aid Anytime and\n Anywhere',
                                textWidthBasis: TextWidthBasis.longestLine,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 19,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              )),
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              child: Image.asset(
                                "images/clipart2665204.png",
                                width: 50,
                                height: 60,
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    // child: IconButton(
                    //     highlightColor: Colors.transparent,
                    //     onPressed: () => _callNumber(),
                    //     icon: Icon(
                    //       color: Colors.black,
                    //       Icons.call_outlined,
                    //       size: 60,
                    //     )),
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
          body: SafeArea(
            child: FutureBuilder(
                future: Patient.getUrgance(),
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
                            Map<String, dynamic> UrganceUrl = {};
                            return IconButton(
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                UrganceUrl.addAll({
                                  "id": list[index].id,
                                  "urgance_libell": list[index].libell
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    settings:
                                        RouteSettings(arguments: UrganceUrl),
                                    builder: (BuildContext context) {
                                      return Sous_urgance_widget();
                                    }));
                              },
                              icon: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color.fromARGB(255, 186, 162, 162),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(12)),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 11,
                                                left: 17,
                                                right: 9,
                                              ),
                                              child: Image.network(
                                                "${list[index].url}",
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child,
                                                    loadingProgress) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  } else
                                                    return Center(
                                                      child: Positioned(
                                                        top: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: loadingProgress
                                                                      .expectedTotalBytes !=
                                                                  null
                                                              ? loadingProgress
                                                                      .cumulativeBytesLoaded /
                                                                  loadingProgress
                                                                      .expectedTotalBytes!
                                                              : null,
                                                        ),
                                                      ),
                                                    );
                                                },
                                                width: 90,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                style: IconButton.styleFrom(
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          190, 135, 130, 113),
                                                  foregroundColor:
                                                      Color.fromARGB(
                                                          250, 113, 60, 14),
                                                ),
                                                icon: Icon(Icons
                                                    .record_voice_over_rounded),
                                                onPressed: () {
                                                  speak(
                                                      "${list[index].libell}");
                                                },
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
                                          overflow: TextOverflow.ellipsis,
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
        )
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
        );
  }
}
