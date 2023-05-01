import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/API/signin.dart';
import 'package:project_pfe/Agent/widgets/cardDrawer.dart';
import 'package:project_pfe/Agent/widgets/listNotifications.dart';
import 'package:project_pfe/Agent/widgets/listUsers.dart';
import 'package:project_pfe/authScreen/Auth.dart';

class HomepageAgent extends StatefulWidget {
  const HomepageAgent({super.key});

  @override
  State<HomepageAgent> createState() => _HomepageAgentState();
}

class _HomepageAgentState extends State<HomepageAgent>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller;
  var user;
  authDetailsUser() async {
    user = APIs.auth.currentUser;
    user.toString();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this, initialIndex: 1);
    authDetailsUser();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.zero,
      child: Scaffold(
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
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/backgroundDrawer.png'))),
                    currentAccountPicture: Image.asset('images/pngwing.png'),
                    accountName: Text(
                      '${user.displayName}',
                      style: TextStyle(
                          fontFamily: 'Poppins_SemiBoldItalic',
                          fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text('${user.email}')),
              ),
              Container(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    cardDrawer(
                        icon: Icons.person_3, title: 'Profile', ontap: () {}),
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
          title: Text(
            'Welcome',
            style: TextStyle(fontFamily: 'PoppinsBold'),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.notification_add))
          ],
          bottom: PreferredSize(
            preferredSize: Size(width, height / 6),
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
        body: TabBarView(
          controller: _tabcontroller,
          children: [ListUsers(), ListNotifications()],
        ),
      ),
    );
  }
}
