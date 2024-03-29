// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/Agent/widgets/cardDrawer.dart';
import 'package:project_pfe/Agent/widgets/listNotifications.dart';
import 'package:project_pfe/Agent/widgets/listUsers.dart';
import 'package:project_pfe/actions/Agent.dart';
import 'package:project_pfe/actions/Person.dart';
import 'package:project_pfe/main.dart';
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
  Agent? _agent;
  String? image;
  String name = 'user name';
  String? mail;
  String? query = "";
  getProfil() async {
    _agent = await Agent.getProfil();
    print(_agent);
    setState(() {
      image = _agent?.image!['url'];
      name = _agent!.complete_name!;
      mail = _agent?.mail;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfil();

    // APIs.CreateUser();

    // APIs.getSelfInfo();
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
                      fit: BoxFit.cover,
                      imageUrl: "${image}",
                      height: 70,
                      width: 70,
                      progressIndicatorBuilder: (context, url, progress) =>
                          Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'images/user.png',
                        fit: BoxFit.cover,
                        height: 170,
                        width: 170,
                      ),
                    ),
                  ),
                  accountName: Text(
                    '${name}',
                    style: TextStyle(
                        fontFamily: 'Poppins_SemiBoldItalic',
                        fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text('${mail}')),
            ),
            Container(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  cardDrawer(
                      icon: Icons.person_3,
                      title: 'Profile',
                      ontap: () async {
                        bool isBack =
                            await Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return EditProfil(
                              type: 'agent',
                            );
                          },
                        ));
                        if (isBack) {
                          await getProfil();
                        }
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
                      ontap: () async {
                        await Person.LogOut();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyApp(
                                    showhome: false,
                                  )),
                          (route) =>
                              false, // Remove all previous routes from the stack
                        );
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
            : null,
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
                    'Demands',
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
