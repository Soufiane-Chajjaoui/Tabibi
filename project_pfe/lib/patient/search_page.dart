import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Urgance.dart';
import 'package:project_pfe/patient/Sous_urgance.dart';
import 'package:project_pfe/patient/searchDelegate.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  final FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  speak(String libell) async {
    await flutterTts.setLanguage("en-AR"); //ar-MO //fr-MA
    await flutterTts.setPitch(1);
    await flutterTts.speak(libell);
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
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.vertical(
              //     bottom: Radius.circular(40),
              //   ),
              // ),
              expandedHeight: 200,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              centerTitle: true,
              forceElevated: true,
              elevation: 4,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background: Container(
                  padding: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Container(
                    color: Color.fromARGB(255, 112, 111, 106),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    alignment: Alignment.centerLeft,
                    // ignore: prefer_const_constructors
                    child: Text(
                      'Recherche',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                centerTitle: true,
                title: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Wrap(
                      children: [
                        TextFormField(
                          onTap: () {
                            showSearch(
                                context: context, delegate: searchdelegate());
                          },
                          cursorColor: Color.fromARGB(255, 74, 66, 66),
                          cursorHeight: 20,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(1),
                              hintStyle: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w500),
                              hintText: 'Urgance,Medciane...',
                              border: OutlineInputBorder(
                                  // gapPadding: 10,
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    // strokeAlign: StrokeAlign.center,
                                    width: 0,
                                    style: BorderStyle.none,
                                  )),
                              prefixIcon: const Icon(Icons.search_outlined),
                              filled: true,
                              fillColor: Color.fromARGB(59, 175, 212, 177)),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
          body: FutureBuilder(
              future: Patient.getUrgance(),
              builder: (context, snapshot) {
                List<Urgance>? list = snapshot.data as List<Urgance>?;
                return !snapshot.hasData
                    ? Center(
                        child: Lottie.asset(
                        'assets/sendLetter.json',
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
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(12)),
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
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
                                                backgroundColor: Color.fromARGB(
                                                    190, 135, 130, 113),
                                                foregroundColor: Color.fromARGB(
                                                    250, 113, 60, 14),
                                              ),
                                              icon: Icon(Icons
                                                  .record_voice_over_rounded),
                                              onPressed: () {
                                                speak("${list[index].libell}");
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
