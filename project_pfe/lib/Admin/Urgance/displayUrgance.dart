import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Urgance.dart';

class displayUrgance extends StatefulWidget {
  const displayUrgance({super.key});

  @override
  State<displayUrgance> createState() => _displayUrganceState();
}

class _displayUrganceState extends State<displayUrgance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Urgance'),
      ),
      body: FutureBuilder(
          future: Urgance.get_urgance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Urgance>? list = snapshot.data as List<Urgance>?;
              return ListView.builder(
                itemCount: list?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: ListTile(
                        trailing: Icon(Icons.delete),
                        title: Text(" ${list![index].libell}  "),
                        leading: Image.memory(
                            base64.decode("${list[index].data_Image}"))),
                  );
                },
              );
            } else
              return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
