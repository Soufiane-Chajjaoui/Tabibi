import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/Agent/widgets/UserCard.dart';
import 'package:project_pfe/Agent/widgets/UserCardLoad.dart';
import 'package:project_pfe/actions/Agent.dart';
import 'package:project_pfe/actions/UserChat.dart';

class ListDoctors extends StatefulWidget {
  const ListDoctors({super.key});

  @override
  State<ListDoctors> createState() => _ListDoctorsState();
}

class _ListDoctorsState extends State<ListDoctors> {
  @override
  Widget build(BuildContext context) {
    final idPatient = ModalRoute.of(context)?.settings.arguments as String;
     return Scaffold(
      appBar: AppBar(
        title: Text('Share With'),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: FutureBuilder(
        future: Agent.getDoctors(),
        builder: (context, snapshot) {
          List<UserChat>? list = snapshot.data as List<UserChat>?;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return ListView.builder(
                itemCount: 8,
                itemBuilder: (context, int i) => SkeletonCardUser());
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
                  itemBuilder: (context, index) => UserCard(
                        selected: () {
                           Agent.ShareWithDoctor(list[index].id as String , idPatient );
                        },
                        User: list[index],
                      ));
            }
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Center(
              child: Lottie.network(
                  "https://assets10.lottiefiles.com/packages/lf20_45z9ii41.json"),
            );
          } else {
            return ListView.builder(
              itemCount: 8,
              itemBuilder: (BuildContext context, int index) {
                return SkeletonCardUser();
              },
            );
          }
        },
      ),
    );
  }
}
