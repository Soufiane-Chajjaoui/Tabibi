import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class testapi extends StatefulWidget {
  const testapi({super.key});

  @override
  State<testapi> createState() => _testapiState();
}

class _testapiState extends State<testapi> {
  List posts = [];
  Future getdata() async {
    var reponse =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    setState(() {
      posts.addAll(jsonDecode(reponse.body));
    });
  }

  @override
  // void initState() {
  //   // TODO: implement initState
  //   getdata();
  //   super.initState();
  // }

  // *********************** without futur builder********************

  Future getdata_with_future_builder() async {
    var reponse = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts?id=3&userId=1"));

    return jsonDecode(reponse.body);
  }

  Future setdata() async {
    var reponse = await http.post(
      Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      body: {
        "userId": "1",
        "title": "tttttttttttttttttt",
        "body": "bbbbbbbbbbbbbbbbbb"
      },
    );
    print(jsonDecode(reponse.body));
  }

  @override
  void initState() {
    super.initState();
    setdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // *********************** without futur builder********************
      // body: posts.isEmpty ? Center(child: CircularProgressIndicator(),) : ListView.builder(
      //     itemCount: posts.length,
      //     itemBuilder: (context, i) {
      //       return Container(
      //         child: Text("${posts[i]['id']}"),
      //       );
      //     }),
      body: FutureBuilder(
        future: getdata_with_future_builder(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length /*this way don't work with me*/,
                itemBuilder: (context, i) {
                  return Container(
                    child: Text("${snapshot.data[i]['title']}"),
                  );
                });
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("test"),
      ),
    );
  }
}
