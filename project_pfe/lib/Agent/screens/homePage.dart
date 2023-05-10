// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/API/signin.dart';
import 'package:project_pfe/Agent/widgets/cardDrawer.dart';
import 'package:project_pfe/Agent/widgets/listNotifications.dart';
import 'package:project_pfe/Agent/widgets/listUsers.dart';
import 'package:project_pfe/Models/ChatUser.dart';
import 'package:project_pfe/authScreen/Auth.dart';
import 'package:project_pfe/patient/EditProfil.dart';

class HomepageAgent extends StatefulWidget {
  const HomepageAgent({super.key});

  @override
  State<HomepageAgent> createState() => _HomepageAgentState();
}

class _HomepageAgentState extends State<HomepageAgent>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  bool isSearch = false;

  String query = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    APIs.CreateUser();

    APIs.getSelfInfo();
    _tabcontroller = TabController(length: 2, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      drawer: Drawer(
        width: width / 1.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          filterQuality: FilterQuality.medium,
                          colorFilter: ColorFilter.mode(
                              Color.fromARGB(193, 174, 96, 96),
                              BlendMode.darken),
                          image: AssetImage(
                            'images/backgroundDrawer.png',
                          ))),
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CachedNetworkImage(
                      imageUrl: APIs.me.image,
                      height: 70,
                      width: 70,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  accountName: Text(
                    '${APIs.me.name}',
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBoldItalic',
                        fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text('${APIs.me.email}')),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  cardDrawer(
                      icon: Icons.person_3,
                      title: 'Profile',
                      ontap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => EditProfil(me: APIs.me)));
                      }),
                  cardDrawer(
                      icon: Icons.notification_important,
                      title: 'Notifications',
                      ontap: () {}),
                  cardDrawer(
                    icon: Icons.event,
                    title: 'Evenements',
                    ontap: () {},
                  ),
                  cardDrawer(
                      icon: Icons.logout_outlined,
                      title: 'Deconnecte',
                      ontap: () {
                        SignOut();
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Auth()));
                      })
                ],
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(139, 170, 57, 57),
        leadingWidth: 20,
        leading: isSearch
            ? Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      isSearch = false;
                    });
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              )
            : Builder(
                builder: (_) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu)),
              ),
        title: isSearch
            ? TextFormField(
                autofocus: true,
                onChanged: (value) {
                  if (isSearch) {
                    setState(() {
                      query = value;
                    });
                  }
                },
                decoration: InputDecoration(
                    hintText: "Recherche",
                    border: OutlineInputBorder(borderSide: BorderSide.none)),
              )
            : Text(
                'Welcome',
                style: TextStyle(fontFamily: 'PoppinsBold'),
              ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  isSearch = !isSearch;
                  query = '';
                });
              },
              icon: Icon(isSearch ? Icons.clear : Icons.search)),
          !isSearch
              ? IconButton(onPressed: () {}, icon: Icon(Icons.notification_add))
              : SizedBox(
                  width: 4,
                )
        ],
        bottom: PreferredSize(
          preferredSize: Size(width, height * .1),
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabcontroller,
              tabs: const [
                Tab(
                  child: Text(
                    'Messages',
                    style: TextStyle(fontFamily: 'Poppins_Reguler'),
                  ),
                ),
                Tab(
                  child: Text(
                    'Notifications',
                    style: TextStyle(fontFamily: 'Poppins_Reguler'),
                  ),
                )
              ]),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async {
          if (isSearch) {
            setState(() {
              isSearch = !isSearch;
              query = '';
            });
            return Future.value(false);
          } else
            return Future.value(true);
        },
        child: TabBarView(
          controller: _tabcontroller,
          children: [
            ListUsers(
              queryfilter: query,
            ),
            ListNotifications()
          ],
        ),
      ),
    );
  }
}
