import 'package:flutter/material.dart';
import 'package:project_pfe/API/api.dart';
import 'package:project_pfe/Agent/widgets/UserCard.dart';
import 'package:project_pfe/Models/ChatUser.dart';
import 'package:project_pfe/actions/Patient.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({super.key, required this.queryfilter});

  final String queryfilter;

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  // For store all users
  List<ChatUser>? users;
  //For storing filtre users
  List<ChatUser>? _users;
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
      body: StreamBuilder(
          stream: APIs.firestore.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => ChatUser.fromJson(e.data())).toList() ?? [];
              if (widget.queryfilter != null) {
                users?.clear();
                users = list
                    .where((s) =>
                        s.name
                            .toLowerCase()
                            .contains(widget.queryfilter.toLowerCase()) ||
                        s.email
                            .toLowerCase()
                            .contains(widget.queryfilter.toLowerCase()))
                    .toList();
              }

              return ListView.builder(
                itemCount:
                    widget.queryfilter == null ? list.length : users?.length,
                itemBuilder: (context, index) => UserCard(
                  chatUser:
                      widget.queryfilter == null ? list[index] : users![index],
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          }),
    );
  }
}
