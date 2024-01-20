import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:project_pfe/Agent/widgets/UserCard.dart';
import 'package:project_pfe/Agent/widgets/UserCardLoad.dart';
import 'package:project_pfe/actions/Doctor.dart';
import 'package:project_pfe/actions/UserChat.dart';

class ListUsersDoctor extends StatefulWidget {
  const ListUsersDoctor({super.key, required this.queryfilter});

  final String? queryfilter;

  @override
  State<ListUsersDoctor> createState() => _ListUsersDoctorState();
}

class _ListUsersDoctorState extends State<ListUsersDoctor> {
  // For store all users
  List<UserChat>? users;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Doctor.getChatPatient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: Padding(
      //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 9),
      //   child: FloatingActionButton.extended(
      //       backgroundColor: Colors.black26,
      //       onPressed: () {},
      //       label: Container(
      //         height: 40,
      //         width: MediaQuery.of(context).size.width,
      //       )),
      // ),
      // body: StreamBuilder(
      //     stream: APIs.firestore.collection("Users").snapshots(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         final data = snapshot.data?.docs;
      //         final list =
      //             data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
      //         if (widget.queryfilter != null) {
      //           users?.clear();
      //           users = list
      //               .where((s) =>
      //                   s.name
      //                       .toLowerCase()
      //                       .contains(widget.queryfilter.toLowerCase()) ||
      //                   s.email
      //                       .toLowerCase()
      //                       .contains(widget.queryfilter.toLowerCase()))
      //               .toList();
      //         }

      //         return ListView.builder(
      //           itemCount:
      //               widget.queryfilter == null ? list.length : users?.length,
      //           itemBuilder: (context, index) => UserCard(
      //             chatUser:
      //                 widget.queryfilter == null ? list[index] : users![index],
      //           ),
      //         );
      //       } else
      //         return Center(
      //           child: CircularProgressIndicator(),
      //         );
      //     }),
      body: FutureBuilder(
          future: Doctor.getChatPatient(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return SkeletonCardUser();
                },
              );
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Lottie.network(
                    "https://assets10.lottiefiles.com/packages/lf20_45z9ii41.json"),
              );
            } else if (snapshot.hasData) {
              List<UserChat> list = snapshot.data as List<UserChat>;
              if (list.isEmpty) {
                return Center(
                  child: Lottie.network(
                      "https://assets2.lottiefiles.com/packages/lf20_wadicnu2.json",
                      width: 100,
                      height: 100),
                );
              } else {
                if (widget.queryfilter != null) {
                  users?.clear();
                  users = list
                      .where((element) => element.username!
                          .toLowerCase()
                          .contains(widget.queryfilter!.toLowerCase()))
                      .toList();
                }
                return ListView.builder(
                    itemCount: widget.queryfilter == null
                        ? list.length
                        : users?.length,
                    itemBuilder: (context, index) => UserCard(
                        User: widget.queryfilter == null
                            ? list[index]
                            : users![index]));
              }
            } else {
              return ListView.builder(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return SkeletonCardUser();
                },
              );
            }
          }),
    );
  }
}
