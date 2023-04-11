import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/Urgance.dart';

class searchdelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('data');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
        child: FutureBuilder(
      future: Patient.getUrgance(),
      builder: (context, snapshot) {
        List<Urgance>? list = snapshot.data as List<Urgance>?;
        List<Urgance>? filter =
            list?.where((element) => element.libell!.contains(query)).toList();
        return !snapshot.hasData
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: filter?.length,
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      print(filter[i].libell);
                    },
                    child: ListTile(
                      title: Text("${filter![i].libell}"),
                    ),
                  );
                });
      },
    ));
  }
}
