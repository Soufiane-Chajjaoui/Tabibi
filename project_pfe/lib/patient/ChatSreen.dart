import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/Agent/widgets/UserCard.dart';
import 'package:project_pfe/Agent/widgets/UserCardLoad.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/UserChat.dart';

class ChatUsersPatient extends StatefulWidget {
  const ChatUsersPatient({super.key});

  @override
  State<ChatUsersPatient> createState() => _ChatUsersPatientState();
}

class _ChatUsersPatientState extends State<ChatUsersPatient> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isAh) {
          return [
            SliverAppBar(
              expandedHeight: 200,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              centerTitle: true,
              forceElevated: true,
              elevation: 4,
              floating: true,
              pinned: false,
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
                      'Chat Box',
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
                      children: [],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: FutureBuilder(
          future: Patient.getUsersChat(),
          builder: (context, snapshot) {
            List<UserChat>? list = snapshot.data as List<UserChat>?;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                  itemCount: list?.length,
                  itemBuilder: (context, i) => SkeletonCardUser());
            } else if (snapshot.hasData) {
              if (list!.isEmpty) {
                return Center(
                  child: Lottie.network(
                      "https://assets2.lottiefiles.com/packages/lf20_wadicnu2.json",
                      width: 100,
                      height: 100),
                );
              } else {
                return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return UserCard(User: list[i]);
                    });
              }
            } else {
              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (context, i) => SkeletonCardUser());
            }
          },
        ),
      ),
    );
  }
}
