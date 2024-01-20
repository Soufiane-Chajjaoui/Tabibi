import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_pfe/actions/Patient.dart';
import 'package:project_pfe/actions/SousSousUrgance.dart';
import 'package:project_pfe/patient/reponseSousSous.dart';

import 'Reponse.dart';

class SousSousUrgance extends StatefulWidget {
  const SousSousUrgance({super.key});

  @override
  State<SousSousUrgance> createState() => _SousSousUrganceState();
}

class _SousSousUrganceState extends State<SousSousUrgance> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   }

 

  @override
  Widget build(BuildContext context) {
    dynamic get_sous_sous_urgance = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(get_sous_sous_urgance['libell']),
      ),
      body: FutureBuilder(
          future: Patient.get_sous_sous_urgance(get_sous_sous_urgance['id']),
          builder: (context, snapshot) {
            List<SousSousUrganceobj>? list =
                snapshot.data as List<SousSousUrganceobj>?;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: list!.length,
                  itemBuilder: (BuildContext context, int i) {
                    return ListTile(
                      title: card_Sous_urg(list[i]),
                    );
                  });
            } else
              return Text("No data available");
          }),
    );
  }

  Card card_Sous_urg(SousSousUrganceobj sous) {
    return Card(
      elevation: 3,
      child: Container(
        height: 70,
        alignment: Alignment.center,
        child: ListTile(
          onTap: () {
            print(sous.id);
            Navigator.of(context).push(MaterialPageRoute(
              settings: RouteSettings(
                  arguments: {'id': sous.id, 'libell': sous.libell}),
              builder: (context) => ReponseScreen(),
            ));
          },
          title: Text(
            "${sous.libell}",
            style: TextStyle(
                fontFamily: 'Poppins_SemiBoldItalic',
                overflow: TextOverflow.ellipsis),
          ),
          leading: CachedNetworkImage(
            imageUrl: "${sous.url}",
            height: 70,
            width: 70,
            progressIndicatorBuilder: (context, url, progress) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Image.asset(
              'images/user.png',
              fit: BoxFit.cover,
              height: 170,
              width: 170,
            ),
          ),
          trailing: Icon(Icons.navigate_next_rounded),
        ),
      ),
    );
  }
}
